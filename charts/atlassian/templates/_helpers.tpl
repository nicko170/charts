{{/* Create chart name and version as used by the chart label */}}
{{- define "chart.name" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "app.name" -}}
  {{- printf "%s-%s" .Chart.Name .Release.Name  | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "chart.labels" -}}
helm.sh/chart: {{ include "chart.name" . }}
  {{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "chart.selectors.crowd" -}}
app.kubernetes.io/name: {{ include "app.name" . }}-crowd
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "chart.selectors.confluence" -}}
app.kubernetes.io/name: {{ include "app.name" . }}-confluence
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "chart.selectors.jira" -}}
app.kubernetes.io/name: {{ include "app.name" . }}-jira
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}