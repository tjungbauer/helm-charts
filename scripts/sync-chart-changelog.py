#!/usr/bin/env python3
"""Sync a chart CHANGELOG.md section from Chart.yaml version and artifacthub.io/changes.

Reads artifacthub.io/changes entries whose description starts with ``(x.y.z)`` matching
Chart.yaml ``version``, maps ``kind`` to Keep a Changelog sections, inserts or
updates ``## [x.y.z] - YYYY-MM-DD``, and adds GitHub compare links at the bottom.

Usage:
  scripts/sync-chart-changelog.py charts/admin-networkpolicies
  scripts/sync-chart-changelog.py charts/admin-networkpolicies --check
"""

from __future__ import annotations

import argparse
import re
import sys
from datetime import date
from pathlib import Path

try:
    import yaml
except ImportError:
    print("error: PyYAML is required (pip install pyyaml)", file=sys.stderr)
    sys.exit(1)

KIND_TO_SECTION = {
    "added": "Added",
    "changed": "Changed",
    "fixed": "Fixed",
    "security": "Security",
    "removed": "Removed",
}

SECTION_ORDER = ("Added", "Changed", "Fixed", "Security", "Removed")
VERSION_TAG_RE = re.compile(r"^\(([^)]+)\)\s*-?\s*(.*)$", re.DOTALL)
VERSION_HEADER_RE = re.compile(r"^## \[([^\]]+)\]\s*-\s*(\d{4}-\d{2}-\d{2})\s*$")
LINK_LINE_RE = re.compile(r"^\[([^\]]+)\]:\s+(https://\S+)\s*$")
COMPARE_BASE = "https://github.com/tjungbauer/helm-charts"


def repo_root() -> Path:
    here = Path(__file__).resolve().parent
    return here.parent


def load_chart(chart_dir: Path) -> tuple[str, str, list]:
    chart_file = chart_dir / "Chart.yaml"
    if not chart_file.is_file():
        raise FileNotFoundError(f"Chart.yaml not found: {chart_file}")

    with chart_file.open(encoding="utf-8") as handle:
        chart = yaml.safe_load(handle)

    version = str(chart.get("version", "")).strip()
    if not version:
        raise ValueError(f"Chart.yaml has no version: {chart_file}")

    annotations = chart.get("annotations") or {}
    changes_yaml = annotations.get("artifacthub.io/changes") or ""
    changes: list = []
    if changes_yaml:
        parsed = yaml.safe_load(changes_yaml)
        if isinstance(parsed, list):
            changes = parsed

    return version, str(chart.get("name", chart_dir.name)), changes


def changes_for_version(changes: list, version: str) -> dict[str, list[str]]:
    grouped: dict[str, list[str]] = {}
    for item in changes:
        if not isinstance(item, dict):
            continue
        kind = str(item.get("kind", "changed")).lower()
        description = str(item.get("description", "")).strip()
        match = VERSION_TAG_RE.match(description)
        if not match:
            continue
        tagged_version, text = match.group(1).strip(), match.group(2).strip()
        if tagged_version != version or not text:
            continue
        section = KIND_TO_SECTION.get(kind, "Changed")
        grouped.setdefault(section, []).append(text)
    return grouped


def build_version_section(version: str, release_date: str, grouped: dict[str, list[str]]) -> str:
    lines = [f"## [{version}] - {release_date}", ""]
    wrote_section = False
    for section in SECTION_ORDER:
        bullets = grouped.get(section, [])
        if not bullets:
            continue
        wrote_section = True
        lines.extend((f"### {section}", ""))
        lines.extend(f"- {bullet}" for bullet in bullets)
        lines.append("")
    if not wrote_section:
        lines.extend(("### Changed", "", "- (no tagged artifacthub.io/changes entries)", ""))
    return "\n".join(lines).rstrip() + "\n\n---\n\n"


def find_version_block(content: str, version: str) -> re.Match[str] | None:
    pattern = re.compile(
        rf"^## \[{re.escape(version)}\]\s*-\s*(\d{{4}}-\d{{2}}-\d{{2}})\s*\n"
        rf"(.*?)"
        rf"(?=^## \[|\Z)",
        re.MULTILINE | re.DOTALL,
    )
    return pattern.search(content)


def find_insert_pos(content: str) -> int | None:
    unreleased = re.search(r"^## \[Unreleased\]", content, re.MULTILINE)
    if not unreleased:
        return None
    rest = content[unreleased.end() :]
    separator = re.search(r"^---\s*$", rest, re.MULTILINE)
    if not separator:
        return None
    return unreleased.end() + separator.end()


def parse_release_versions(content: str) -> list[str]:
    versions: list[str] = []
    for line in content.splitlines():
        match = VERSION_HEADER_RE.match(line)
        if match and match.group(1) != "Unreleased":
            versions.append(match.group(1))
    return versions


def split_footer(content: str) -> tuple[str, dict[str, str]]:
    lines = content.rstrip().splitlines()
    link_lines: list[tuple[int, str, str]] = []
    i = len(lines) - 1
    while i >= 0:
        stripped = lines[i].strip()
        if stripped == "":
            if link_lines:
                break
            i -= 1
            continue
        match = LINK_LINE_RE.match(lines[i])
        if match:
            link_lines.insert(0, (i, match.group(1), match.group(2)))
            i -= 1
            continue
        break

    if not link_lines:
        body = content if content.endswith("\n") else content + "\n"
        return body, {}

    body_end = link_lines[0][0]
    body = "\n".join(lines[:body_end]).rstrip() + "\n"
    links = {version: url for _, version, url in link_lines}
    return body, links


def expected_compare_links(versions: list[str], chart_slug: str, existing_links: dict[str, str]) -> dict[str, str]:
    links: dict[str, str] = {}
    for index, version in enumerate(versions):
        if index + 1 < len(versions):
            previous = versions[index + 1]
            links[version] = (
                f"{COMPARE_BASE}/compare/{chart_slug}-{previous}...{chart_slug}-{version}"
            )
        else:
            oldest = version
            if oldest in existing_links and "/tree/" in existing_links[oldest]:
                links[oldest] = existing_links[oldest]
            else:
                links[oldest] = (
                    f"{COMPARE_BASE}/tree/{chart_slug}-{oldest}/charts/{chart_slug}"
                )
    return links


def upsert_footer_links(content: str, chart_slug: str, current_version: str) -> tuple[str, bool]:
    body, existing_links = split_footer(content)
    versions = parse_release_versions(body)
    if not versions:
        return content, False

    expected = expected_compare_links(versions, chart_slug, existing_links)
    merged = dict(existing_links)
    changed = False

    for version in versions:
        if version not in merged:
            merged[version] = expected[version]
            changed = True

    if current_version in expected and merged.get(current_version) != expected[current_version]:
        merged[current_version] = expected[current_version]
        changed = True

    if not changed:
        return content, False

    footer_lines = [f"[{version}]: {merged[version]}" for version in versions if version in merged]
    for version in sorted(existing_links):
        if version not in versions:
            footer_lines.append(f"[{version}]: {existing_links[version]}")

    new_content = body.rstrip() + "\n\n" + "\n".join(footer_lines) + "\n"
    if new_content.rstrip() + "\n" == content.rstrip() + "\n":
        return content, False
    return new_content, True


def upsert_version_section(content: str, version: str, grouped: dict[str, list[str]]) -> tuple[str, bool]:
    existing = find_version_block(content, version)

    if existing:
        release_date = existing.group(1)
        new_section = build_version_section(version, release_date, grouped)
        new_content = content[: existing.start()] + new_section + content[existing.end() :]
    else:
        release_date = date.today().isoformat()
        new_section = build_version_section(version, release_date, grouped)
        insert_pos = find_insert_pos(content)
        if insert_pos is None:
            if content.endswith("\n"):
                new_content = content + "\n---\n\n" + new_section
            else:
                new_content = content + "\n\n---\n\n" + new_section
        else:
            remainder = content[insert_pos:].lstrip("\n")
            new_content = content[:insert_pos] + "\n" + new_section + remainder

    if new_content == content:
        return content, False

    return new_content, True


def apply_changelog_sync(content: str, version: str, chart_slug: str, grouped: dict[str, list[str]]) -> tuple[str, bool]:
    content, section_changed = upsert_version_section(content, version, grouped)
    content, links_changed = upsert_footer_links(content, chart_slug, version)
    return content, section_changed or links_changed


def upsert_changelog(changelog_path: Path, version: str, chart_slug: str, grouped: dict[str, list[str]]) -> bool:
    content = changelog_path.read_text(encoding="utf-8")
    new_content, changed = apply_changelog_sync(content, version, chart_slug, grouped)
    if not changed:
        return False

    changelog_path.write_text(new_content, encoding="utf-8")
    return True


def ensure_changelog(chart_dir: Path, chart_name: str) -> Path:
    changelog_path = chart_dir / "CHANGELOG.md"
    if changelog_path.is_file():
        return changelog_path

    template = f"""# Changelog

All notable changes to the **{chart_name}** Helm chart are documented in this file.

---

## [Unreleased]

### Added

- (nothing yet)

### Changed

- (nothing yet)

### Fixed

- (nothing yet)

---

"""
    changelog_path.write_text(template, encoding="utf-8")
    return changelog_path


def sync_chart(chart_dir: Path, check_only: bool = False) -> tuple[bool, str]:
    chart_dir = chart_dir.resolve()
    version, chart_name, changes = load_chart(chart_dir)
    grouped = changes_for_version(changes, version)

    if not grouped:
        return False, (
            f"no artifacthub.io/changes entries tagged with ({version}) in {chart_dir.name}; "
            "add e.g. description: (1.0.11) your change summary"
        )

    changelog_path = ensure_changelog(chart_dir, chart_name)
    chart_slug = chart_dir.name
    content = changelog_path.read_text(encoding="utf-8")

    if check_only:
        if apply_changelog_sync(content, version, chart_slug, grouped)[1]:
            return True, f"CHANGELOG.md out of sync for {chart_name} {version}"
        return False, f"CHANGELOG.md already in sync for {chart_name} {version}"

    changed = upsert_changelog(changelog_path, version, chart_slug, grouped)
    if changed:
        return True, (
            f"synced CHANGELOG.md for {chart_name} {version} "
            f"(release section and compare links) from Chart.yaml artifacthub.io/changes"
        )
    return False, f"CHANGELOG.md already in sync for {chart_name} {version}"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "chart_dir",
        type=Path,
        help="Path to chart directory (e.g. charts/admin-networkpolicies)",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="Exit 1 when CHANGELOG would change; do not write files",
    )
    args = parser.parse_args()

    chart_dir = args.chart_dir
    if not chart_dir.is_absolute():
        chart_dir = repo_root() / chart_dir

    try:
        changed, message = sync_chart(chart_dir, check_only=args.check)
    except (FileNotFoundError, ValueError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    print(message)
    if args.check and changed:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
