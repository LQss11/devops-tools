resource "kubernetes_manifest" "deployment_nginx_deployment" {
  depends_on = [local_file.kubeconfig]
  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "namespace" = "default",
      "labels" = {
        "app" = "nginx"
      }
      "name" = "nginx-deployment"
    }
    "spec" = {
      "replicas" = 3
      "selector" = {
        "matchLabels" = {
          "app" = "nginx"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "nginx"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "nginx:alpine"
              "name"  = "nginx"
              "ports" = [
                {
                  "containerPort" = 80
                },
              ]
            },
          ]
        }
      }
    }
  }
}

resource "kubernetes_manifest" "service_nginx_service" {
  depends_on = [local_file.kubeconfig]
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "namespace" = "default",
      "name"      = "nginx-service"
    }
    "spec" = {
      "ports" = [
        {
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = 80
        },
      ]
      "selector" = {
        "app" = "nginx"
      }
      "type" = "LoadBalancer"
    }
  }
}
