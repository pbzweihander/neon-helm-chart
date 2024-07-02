{{/*
Expand the name of the chart.
*/}}
{{- define "neon.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "neon.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "neon.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "neon.labels" -}}
helm.sh/chart: {{ include "neon.chart" . }}
app.kubernetes.io/name: {{ include "neon.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "neon.computeNode.labels" -}}
{{ include "neon.labels" . }}
app.kubernetes.io/component: compute-node
{{- end }}

{{- define "neon.pageserver.labels" -}}
{{ include "neon.labels" . }}
app.kubernetes.io/component: pageserver
{{- end }}

{{- define "neon.safekeeper.labels" -}}
{{ include "neon.labels" . }}
app.kubernetes.io/component: safekeeper
{{- end }}

{{- define "neon.storageBroker.labels" -}}
{{ include "neon.labels" . }}
app.kubernetes.io/component: storage-broker
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "neon.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "neon.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
