apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: applications
  namespace: argocd
spec:
  goTemplate: true
  goTemplateOptions: ['missingkey=error']
  generators:
    - git:
        repoURL: https://github.com/bakseter/whpah
        revision: HEAD
        directories:
          - path: manifests/applications/**
  template:
    metadata:
      name: '{{.path.basename}}'
      labels:
        bakseter.net/type: 'application'
    spec:
      project: default
      source:
        repoURL: https://github.com/bakseter/whpah
        targetRevision: HEAD
        path: '{{.path.path}}'
        directory:
          recurse: true
      destination:
        server: https://kubernetes.default.svc
        namespace: '{{.path.basename}}'
      syncPolicy:
        automated:
          selfHeal: true
          prune: true
        syncOptions:
          - CreateNamespace=true
          - ServerSideApply=true
