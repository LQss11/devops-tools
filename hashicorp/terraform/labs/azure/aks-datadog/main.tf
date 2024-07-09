resource "azurerm_resource_group" "main" {
  name     = "${var.env}-aks"
  location = "West Europe"
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.env}-main-aks1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.env}-mainaks1"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_A2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}


# Resource to create the kube config file
resource "local_file" "kubeconfig" {
  content  = azurerm_kubernetes_cluster.main.kube_config_raw
  filename = "${path.module}/${var.kubeconfig_name}"
}


resource "helm_release" "datadog_agent" {
  depends_on = [local_file.kubeconfig]

  name = "aks-datadog-agent"

  repository = "https://helm.datadoghq.com"
  chart      = "datadog"

  set {
    name  = "datadog.site"
    value = "us3.datadoghq.com"
  }
  set {
    name  = "datadog.kubelet.tlsVerify"
    value = false
  }
  set {
    name  = "datadog.apiKey"
    value = "mykey"
  }
}
