{{/* laravel labels shared across objects */}}
{{- define "laravel.labels" -}}
helm.sh/chart: {{ include "laravel.names.chart" . }}
  {{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* Selector labels shared across objects */}}
{{- define "laravel.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "laravel.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* worker labels shared across objects */}}
{{- define "laravel.labels.web" -}}
app.kubernetes.io/name: {{ include "laravel.names.name" . }}-web
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* worker labels shared across objects */}}
{{- define "laravel.labels.worker" -}}
app.kubernetes.io/name: {{ include "laravel.names.name" . }}-worker
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* cron labels shared across objects */}}
{{- define "laravel.labels.cron" -}}
app.kubernetes.io/name: {{ include "laravel.names.name" . }}-cron
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/* Allow KubeVersion to be overridden. */}}
{{- define "laravel.capabilities.ingress.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Ingress objects */}}
{{- define "laravel.capabilities.ingress.apiVersion" -}}
  {{- print "networking.k8s.io/v1" -}}
  {{- if semverCompare "<1.19" (include "laravel.capabilities.ingress.kubeVersion" .) -}}
    {{- print "beta1" -}}
  {{- end -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "laravel.capabilities.ingress.isStable" -}}
  {{- if eq (include "laravel.capabilities.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
    {{- true -}}
  {{- end -}}
{{- end -}}


{{/* Expand the name of the chart */}}
{{- define "laravel.names.name" -}}
  {{- $globalNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalNameOverride = (default $globalNameOverride .Values.global.nameOverride) -}}
  {{- end -}}
  {{- default .Chart.Name (default .Values.nameOverride $globalNameOverride) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "laravel.names.fullname" -}}
  {{- $name := include "laravel.names.name" . -}}
  {{- $globalFullNameOverride := "" -}}
  {{- if hasKey .Values "global" -}}
    {{- $globalFullNameOverride = (default $globalFullNameOverride .Values.global.fullnameOverride) -}}
  {{- end -}}
  {{- if or .Values.fullnameOverride $globalFullNameOverride -}}
    {{- $name = default .Values.fullnameOverride $globalFullNameOverride -}}
  {{- else -}}
    {{- if contains $name .Release.Name -}}
      {{- $name = .Release.Name -}}
    {{- else -}}
      {{- $name = printf "%s-%s" .Release.Name $name -}}
    {{- end -}}
  {{- end -}}
  {{- trunc 63 $name | trimSuffix "-" -}}
{{- end -}}

{{/* Create chart name and version as used by the chart label */}}
{{- define "laravel.names.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Create the name of the ServiceAccount to use */}}
{{- define "laravel.names.serviceAccountName" -}}
  {{- if .Values.serviceAccount.create -}}
    {{- default (include "laravel.names.fullname" .) .Values.serviceAccount.name -}}
  {{- else -}}
    {{- default "default" .Values.serviceAccount.name -}}
  {{- end -}}
{{- end -}}

{{/* Return the properly cased version of the controller type */}}
{{- define "laravel.names.controllerType" -}}
  {{- if eq .Values.controller.type "deployment" -}}
    {{- print "Deployment" -}}
  {{- else if eq .Values.controller.type "daemonset" -}}
    {{- print "DaemonSet" -}}
  {{- else if eq .Values.controller.type "statefulset"  -}}
    {{- print "StatefulSet" -}}
  {{- else -}}
    {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) -}}
  {{- end -}}
{{- end -}}
