resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  version          = "v3.3.2"

    values = [file("values/argocd.yaml")]

#  values = [<<-EOT
#      server:
#        service:
#          type: NodePort  # Changed from LoadBalancer
      
      # Inject the Ingress configuration directly into the chart
#        ingress:
#          enabled: true
#          ingressClassName: gce
#          annotations:
#            kubernetes.io/ingress.global-static-ip-name: "lb-static-ip"
#            ingress.gcp.kubernetes.io/pre-shared-cert: "argocd-cert"
#            kubernetes.io/ingress.allow-http: "false"
#          hosts:
#            - argocd.example.com
#      
#        params:
#          server.insecure: true # Required for GCLB backends
#
#      global:
#        domain: argocd.example.com
#    EOT
#  ]

}
