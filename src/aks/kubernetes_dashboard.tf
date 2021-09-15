# docs
# https://github.com/kubernetes/dashboard#install
# https://artifacthub.io/packages/helm/k8s-dashboard/kubernetes-dashboard
resource "kubernetes_namespace" "kubernetes_dashboard" {
  metadata {
    name = "kubernetes-dashboard"
  }
}

resource "helm_release" "kubernetes_dashboard" {
  name       = "kubernetes-dashboard"
  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"
  version    = "5.0.0"
  namespace  = kubernetes_namespace.kubernetes_dashboard.metadata[0].name

  # set {
  #   name  = "service.externalPort"
  #   value = var.default_service_port
  # }
}

resource "kubernetes_ingress" "kubernetes_dashboard_ingress" {
  depends_on = [helm_release.kubernetes_dashboard]

  metadata {
    name      = "${kubernetes_namespace.kubernetes_dashboard.metadata[0].name}-ingress"
    namespace = kubernetes_namespace.kubernetes_dashboard.metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
      "nginx.ingress.kubernetes.io/ssl-redirect"   = "false"
      "nginx.ingress.kubernetes.io/use-regex"      = "true"
    }
  }

  spec {
    rule {

      host = "kubernetes-dashboard.dev.cstar.pagopa.it"

      http {

        path {
          backend {
            service_name = "kubernetes-dashboard"
            service_port = 8443
          }
          path = "/(.*)"
        }

      }
    }
  }
}
