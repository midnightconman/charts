{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "gitea.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gitea.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified postgresql name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "gitea.postgresql.fullname" -}}
{{- $name := default "postgresql" .Values.postgresql.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Determine database user based on use of postgresql dependency.
*/}}
{{- define "gitea.database.host" -}}
{{- if .Values.postgresql.install -}}
{{- template "gitea.postgresql.fullname" . -}}
{{- else -}}
{{- .Values.service.gitea.databaseHost | quote -}}
{{- end -}}
{{- end -}}

{{/*
Determine database user based on use of postgresql dependency.
*/}}
{{- define "gitea.database.user" -}}
{{- if .Values.postgresql.install -}}
{{- .Values.postgresql.postgresUser | quote -}}
{{- else -}}
{{- .Values.service.gitea.databaseUser | quote -}}
{{- end -}}
{{- end -}}

{{/*
Determine database password based on use of postgresql dependency.
*/}}
{{- define "gitea.database.password" -}}
{{- if .Values.postgresql.install -}}
{{- .Values.postgresql.postgresPassword | quote -}}
{{- else -}}
{{- .Values.service.gitea.databasePassword | quote -}}
{{- end -}}
{{- end -}}

{{/*
Determine database name based on use of postgresql dependency.
*/}}
{{- define "gitea.database.name" -}}
{{- if .Values.postgresql.install -}}
{{- .Values.postgresql.postgresDatabase | quote -}}
{{- else -}}
{{- .Values.service.gitea.databaseName | quote -}}
{{- end -}}
{{- end -}}