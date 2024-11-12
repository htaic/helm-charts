{{/*
  Setting proxyOrigin
*/}}
{{- define "getReverseProxyOrigin" -}}
  {{- $env := .Values.global.environment -}}  
  {{- $proxyOrigin := index .Values.reverseProxyOrigins $env -}}  
  {{- if $proxyOrigin -}}
    {{- $proxyOrigin -}}  
  {{- else -}}
    {{- printf "http://default.example.com" -}}  
  {{- end -}}
{{- end -}}