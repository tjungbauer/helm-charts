<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Helm Charts - stderr.at</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="Helm Charts Repository for GitOps cluster configuration and OpenShift management">
  <meta name="theme-color" content="#252c33">

  <!-- SEO & Social Media -->
  <meta property="og:title" content="Helm Charts - stderr.at">
  <meta property="og:description" content="Central storage for GitOps Helm charts">
  <meta property="og:type" content="website">

  <!-- Icons -->
  <link rel="icon" type="image/x-icon" href="images/favicon-152.png">
  <link rel="icon" type="image/png" href="images/favicon-152.png">
  <link rel="apple-touch-icon" href="images/favicon-152.png">

  <!-- Styles (fonts are loaded locally via CSS) -->
  <link rel="stylesheet" href="css/styles.css">
</head>

<body>
  <div class="helm-charts-page">
    <h1 class="gradient-header">Helm Charts</h1>

    <div class="helm-intro">
      <p>
        Welcome to my Helm Repository! This collection serves as a central storage for my GitOps approach to cluster management.
        Whenever I spin up a new OpenShift cluster, these charts help me configure it quickly and consistently.
      </p>
      <p>
        The charts are primarily used by my <a href="https://github.com/tjungbauer/openshift-clusterconfig-gitops">OpenShift GitOps cluster configuration project</a>.
      </p>
      <p>
        For detailed information and usage examples, please check out my blog: <a href="https://blog.stderr.at/gitopscollection/">GitOps Collection</a>
      </p>
      <p>
        Feel free to test these charts and let me know if you encounter any issues or have suggestions for improvements.
      </p>
    </div>

    <div class="helm-search-container">
      <input type="search" 
             id="chart-search" 
             placeholder="Search charts by name, description or tags..." 
             class="helm-search-input">
    </div>

    <div class="helm-chart-stats">
      <p><span id="chart-count">{{ len .Entries }}</span> charts available</p>
    </div>

    <div id="charts-container" class="helm-charts-grid">
      {{ range $key, $chartEntry := .Entries }}
      {{ $chart := index $chartEntry 0 }}
      {{ if not $chart.Deprecated }}
      <div class="helm-chart-card" 
           data-name="{{ $chart.Name }}"
           data-description="{{ $chart.Description }}"
           data-keywords="{{ range $chart.Keywords }}{{ . }} {{ end }}"
           onclick="window.open('{{ $chart.Home }}', '_blank')">
        <div class="helm-chart-top">
          {{ if $chart.Icon }}
          <div class="helm-chart-icon" style="background-image: url('{{ $chart.Icon }}')" title="{{ $chart.Name }}"></div>
          {{ end }}
          <div class="helm-chart-info">
            <h3 class="helm-chart-title">{{ $chart.Name }}</h3>
            {{ if $chart.Maintainers }}
            <div class="helm-chart-maintainer">
              <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
                <path d="M224 256A128 128 0 1 0 224 0a128 128 0 1 0 0 256zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z"/>
              </svg>
              {{ range $i, $m := $chart.Maintainers }}{{ if $i }}, {{ end }}{{ $m.Name }}{{ end }}
            </div>
            {{ end }}
          </div>
        </div>

        <div class="helm-chart-actions" onclick="event.stopPropagation()">
          {{ if $chart.Home }}
          <a href="{{ $chart.Home }}" target="_blank" rel="noopener noreferrer" class="helm-chart-btn" title="View source">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512">
              <path d="M165.9 397.4c0 2-2.3 3.6-5.2 3.6-3.3.3-5.6-1.3-5.6-3.6 0-2 2.3-3.6 5.2-3.6 3-.3 5.6 1.3 5.6 3.6zm-31.1-4.5c-.7 2 1.3 4.3 4.3 4.9 2.6 1 5.6 0 6.2-2s-1.3-4.3-4.3-5.2c-2.6-.7-5.5.3-6.2 2.3zm44.2-1.7c-2.9.7-4.9 2.6-4.6 4.9.3 2 2.9 3.3 5.9 2.6 2.9-.7 4.9-2.6 4.6-4.6-.3-1.9-3-3.2-5.9-2.9zM244.8 8C106.1 8 0 113.3 0 252c0 110.9 69.8 205.8 169.5 239.2 12.8 2.3 17.3-5.6 17.3-12.1 0-6.2-.3-40.4-.3-61.4 0 0-70 15-84.7-29.8 0 0-11.4-29.1-27.8-36.6 0 0-22.9-15.7 1.6-15.4 0 0 24.9 2 38.6 25.8 21.9 38.6 58.6 27.5 72.9 20.9 2.3-16 8.8-27.1 16-33.7-55.9-6.2-112.3-14.3-112.3-110.5 0-27.5 7.6-41.3 23.6-58.9-2.6-6.5-11.1-33.3 2.6-67.9 20.9-6.5 69 27 69 27 20-5.6 41.5-8.5 62.8-8.5s42.8 2.9 62.8 8.5c0 0 48.1-33.6 69-27 13.7 34.7 5.2 61.4 2.6 67.9 16 17.7 25.8 31.5 25.8 58.9 0 96.5-58.9 104.2-114.8 110.5 9.2 7.9 17 22.9 17 46.4 0 33.7-.3 75.4-.3 83.6 0 6.5 4.6 14.4 17.3 12.1C428.2 457.8 496 362.9 496 252 496 113.3 383.5 8 244.8 8z"/>
            </svg>
            Source
          </a>
          {{ end }}
          {{ if $chart.Urls }}
          <a href="{{ index $chart.Urls 0 }}" target="_blank" rel="noopener noreferrer" class="helm-chart-btn" title="Download">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
              <path d="M169.4 470.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L224 370.8 224 64c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 306.7L54.6 265.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"/>
            </svg>
            Download
          </a>
          {{ end }}
        </div>

        <p class="helm-chart-description">{{ $chart.Description }}</p>

        <div class="helm-chart-meta">
          <span class="helm-chart-meta-item">📦 v{{ $chart.Version }}</span>
          {{ if $chart.Created }}
          <span class="helm-chart-meta-item">📅 {{ $chart.Created.Format "2006-01-02" }}</span>
          {{ end }}
          <a href="https://artifacthub.io/packages/helm/openshift-bootstraps/{{ $chart.Name }}" target="_blank" rel="noopener noreferrer" class="helm-chart-meta-link" onclick="event.stopPropagation()">
            ArtifactHub
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="external-link-icon">
              <path d="M320 0c-17.7 0-32 14.3-32 32s14.3 32 32 32h82.7L201.4 265.4c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L448 109.3V192c0 17.7 14.3 32 32 32s32-14.3 32-32V32c0-17.7-14.3-32-32-32H320zM80 32C35.8 32 0 67.8 0 112V432c0 44.2 35.8 80 80 80H400c44.2 0 80-35.8 80-80V320c0-17.7-14.3-32-32-32s-32 14.3-32 32V432c0 8.8-7.2 16-16 16H80c-8.8 0-16-7.2-16-16V112c0-8.8 7.2-16 16-16H192c17.7 0 32-14.3 32-32s-14.3-32-32-32H80z"/>
            </svg>
          </a>
        </div>

        {{ if $chart.Keywords }}
        <div class="helm-chart-tags">
          {{ range $chart.Keywords }}
          <span class="helm-chart-tag">{{ . }}</span>
          {{ end }}
        </div>
        {{ end }}
      </div>
      {{ end }}
      {{ end }}
    </div>

    <!-- Deprecated Charts Section -->
    <div id="deprecated-section" class="deprecated-section">
      <details class="deprecated-details">
        <summary class="deprecated-summary">
          <span class="deprecated-header">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="currentColor" class="deprecated-icon">
              <path d="M256 32c14.2 0 27.3 7.5 34.5 19.8l216 368c7.3 12.4 7.3 27.7 .2 40.1S486.3 480 472 480H40c-14.3 0-27.6-7.7-34.7-20.1s-7-27.8 .2-40.1l216-368C228.7 39.5 241.8 32 256 32zm0 128c-13.3 0-24 10.7-24 24V296c0 13.3 10.7 24 24 24s24-10.7 24-24V184c0-13.3-10.7-24-24-24zm32 224a32 32 0 1 0 -64 0 32 32 0 1 0 64 0z"/>
            </svg>
            Deprecated Charts
          </span>
          <span class="deprecated-hint expand-hint">Click to expand</span>
          <span class="deprecated-hint collapse-hint">Click to close</span>
        </summary>
        <div class="helm-charts-grid deprecated-grid">
          {{ range $key, $chartEntry := .Entries }}
          {{ $chart := index $chartEntry 0 }}
          {{ if $chart.Deprecated }}
          <div class="helm-chart-card deprecated">
            <div class="helm-chart-top">
              {{ if $chart.Icon }}
              <div class="helm-chart-icon" style="background-image: url('{{ $chart.Icon }}')" title="{{ $chart.Name }}"></div>
              {{ end }}
              <div class="helm-chart-info">
                <h3 class="helm-chart-title">{{ $chart.Name }}</h3>
                <span class="helm-deprecated-badge">Deprecated</span>
              </div>
            </div>
            <p class="helm-chart-description">{{ $chart.Description }}</p>
            <div class="helm-chart-meta">
              <span class="helm-chart-meta-item">📦 v{{ $chart.Version }}</span>
            </div>
          </div>
          {{ end }}
          {{ end }}
        </div>
      </details>
    </div>

    <h2 class="gradient-header">Getting Started</h2>
    <p>To use these Helm charts, add this repository to your Helm configuration:</p>
    <pre><code>helm repo add tjungbauer https://charts.stderr.at/
helm repo update</code></pre>

    <p>Then install any chart:</p>
    <pre><code>helm install my-release tjungbauer/&lt;chart-name&gt;</code></pre>

    <p>
      These Charts are used to make my life easier when I need to install a Demo-Environment. Anyone is free to use them and make suggestions.<br>
      Mainly used by: <a href="https://github.com/tjungbauer/openshift-clusterconfig-gitops">https://github.com/tjungbauer/openshift-clusterconfig-gitops</a>
    </p>

    <!-- License Footer -->
    <div class="helm-license-footer">
      <div class="helm-license-section">
        <h2 class="gradient-header">License</h2>
        <p class="helm-copyright">Copyright © 2025 Thomas Jungbauer</p>
        <p>
          Licensed under the <a href="http://www.apache.org/licenses/LICENSE-2.0" target="_blank" rel="noopener noreferrer">Apache License, Version 2.0</a> (the "License");
          you may not use this file except in compliance with the License.
        </p>
        <p class="helm-license-disclaimer">
          Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
          WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and
          limitations under the License.
        </p>
      </div>
      <div class="helm-icons-section">
        <h2 class="gradient-header">Icons</h2>
        <p>Various Artists - <a href="https://www.flaticon.com/" target="_blank" rel="noopener noreferrer">Flaticon</a> and <a href="https://www.redhat.com/" target="_blank" rel="noopener noreferrer">Red Hat</a></p>
      </div>
    </div>
  </div>

  <time class="time" datetime="{{ .Generated.Format "2006-01-02T15:04:05" }}" pubdate id="generated" style="display:none;">{{ .Generated.Format "Mon Jan 2 2006 03:04:05PM MST-07:00" }}</time>

  <script>
  document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('chart-search');
    const chartCards = document.querySelectorAll('.helm-chart-card:not(.deprecated)');
    const countElement = document.getElementById('chart-count');
    
    if (searchInput) {
      searchInput.addEventListener('input', function(e) {
        const query = e.target.value.toLowerCase();
        
        let visibleCount = 0;
        chartCards.forEach(card => {
          const name = (card.dataset.name || '').toLowerCase();
          const description = (card.dataset.description || '').toLowerCase();
          const keywords = (card.dataset.keywords || '').toLowerCase();
          
          const matches = name.includes(query) || 
                         description.includes(query) || 
                         keywords.includes(query);
          
          card.style.display = matches ? '' : 'none';
          if (matches) visibleCount++;
        });

        if (countElement) {
          countElement.textContent = query ? visibleCount : chartCards.length;
        }
      });
    }

    // Scroll to top
    const scrollToTopBtn = document.getElementById('scroll-to-top');
    if (scrollToTopBtn) {
      window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
          scrollToTopBtn.classList.add('visible');
        } else {
          scrollToTopBtn.classList.remove('visible');
        }
      });

      scrollToTopBtn.addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });
    }
  });
  </script>

  <button id="scroll-to-top" class="scroll-to-top" aria-label="Scroll to top" title="Scroll to top">
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="18,15 12,9 6,15"></polyline>
    </svg>
  </button>
</body>
</html>
