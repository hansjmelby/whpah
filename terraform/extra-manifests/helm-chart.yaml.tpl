apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: argocd
  namespace: argocd
spec:
  repo: https://argoproj.github.io/argo-helm
  chart: argo-cd
  targetNamespace: argocd
  valuesContent: |-
    global:
      domain: argocd.melby.casa

      networkPolicy:
        create: true

    configs:
      repositories:
        argocd:
          url: https://github.com/hansjmelby/whpah.git

      dex:
        enabled: false
