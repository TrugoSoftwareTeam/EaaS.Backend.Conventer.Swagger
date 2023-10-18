{{- define "get_env_vars_from_secrets_manager" -}}
{{- if eq .Values.config.secretsManager true }}
{{- if and .Values.config.secretDependencies }}
{{- range $key, $value := .Values.config.secretDependencies }} {{/* Get infra generated secrets from secrets manager  */}}
{{- if eq $value true }}
- find:
   path: "/{{ $key }}"
   name: 
     regexp: ".*"
  rewrite:
  - regexp:
      source: "^[/]?[a-zA-Z0-9]+(.|-|_)+[/$]" 
      target: ""
{{- end }} 
{{- end }} 
{{- end }} {{/* Recursively pulls secrets under path "/APP_NAME" from aws secrets manager  */}}
- find:
   path: "/{{ .Values.config.APP_NAME }}"
   name: 
     regexp: ".*"
  rewrite:
  - regexp:
      source: "^[/]?[a-zA-Z0-9]+(.|-|_)+[/$]"
      target: ""
{{- end }}
{{- end }}

{{- define "get_env_vars_from_parameter_store" -}}
{{- if eq .Values.config.parameterStore true }}
{{- if and .Values.config.parameterDependencies }}
{{- range $key, $value := .Values.config.parameterDependencies }} {{/* Get infra generated parameters from parameter store  */}}
{{- if eq $value true }}
- find:
   path: "/{{ $key }}"
   name: 
     regexp: ".*"
  rewrite:
  - regexp:
      source: "^[/]?[a-zA-Z0-9]+(.|-|_)+[/$]" 
      target: ""
{{- end }} 
{{- end }} 
{{- end }} {{/* Recursively pulls parameters under path "/APP_NAME" from aws parameter store  */}}
- find:
   path: "/{{ .Values.config.APP_NAME }}"
   name: 
     regexp: ".*"
  rewrite:
  - regexp:
      source: "^[/]?[a-zA-Z0-9]+(.|-|_)+[/$]"
      target: ""
{{- end }}
{{- end }}