apiVersion: argoproj.io/v1alpha1
kind: ApplicationSet
metadata:
  name: cluster-addons
  namespace: argocd
spec:
  goTemplate: true
  goTemplateOptions: ['missingkey=error']
  generators:
    - git:
        repoURL: https://github.com/hansjmelby/whpah
        revision: HEAD
        directories:
          - path: manifests/cluster-addons/**
  template:
    metadata:
      name: '{{.path.basename}}'
      labels:
        melby.casa/type: 'cluster-addon'
    spec:
      project: default
      source:
        repoURL: https://github.com/hansjmelby/whpah
        targetRevision: HEAD
        path: '{{.path.path}}'
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
