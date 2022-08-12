{{/*
Expand the name of the chart.
*/}}

{{- define "kube-media.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kube-media.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "kube-media.labels" -}}
helm.sh/chart: {{ include "kube-media.chart" . }}
{{ include "kube-media.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "kube-media.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kube-media.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "kube-media.serviceAccountName" -}}
{{- if .Values.plex.kubePlex.serviceAccount.create }}
{{- default (include "kube-media.name" .) .Values.plex.kubePlex.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.plex.kubePlex.serviceAccount.name }}
{{- end }}
{{- end }}
