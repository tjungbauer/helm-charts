{{- define "tpl.tolerations.override" -}}
tolerations:
{{- range . }}
- effect: {{ .effect }}
  key: {{ .key }}
  operator: {{ .operator }}
  value: {{ .value }}
  {{- if .tolerationSeconds }}
  tolerationSeconds: {{ .tolerationSeconds }}
  {{- end }}
{{- end }}
{{- end -}}

{{- define "tpl.tolerations.uwm_override" -}}
tolerations:
{{- range . }}
- effect: {{ .effect }}
  key: {{ .key }}
  operator: {{ .operator }}
  value: {{ .value }}
  {{- if .tolerationSeconds }}
  tolerationSeconds: {{ .tolerationSeconds }}
  {{- end }}
{{- end }}
{{- end -}}

{{- define "tpl.nodeExporter.collectors" -}}
collectors:
  buddyinfo:
  {{- if .buddyinfo }}
{{ toYaml .buddyinfo | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  cpufreq:
  {{- if .cpufreq }}
{{ toYaml .cpufreq | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  ksmd:
  {{- if .ksmd }}
{{ toYaml .ksmd | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  mountstats:
  {{- if .mountstats }}
{{ toYaml .mountstats | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  netclass:
  {{- if .netclass }}
{{ toYaml .netclass | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  netdev:
  {{- if .netdev }}
{{ toYaml .netdev | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  processes:
  {{- if .processes }}
{{ toYaml .processes | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  systemd:
  {{- if .systemd }}
{{ toYaml .systemd | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
  tcpstat:
  {{- if .tcpstat }}
{{ toYaml .tcpstat | indent 6 }}
  {{- else -}}
    {{ " {}" }}
  {{- end }}
{{- end }}
