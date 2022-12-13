# Usa el nombre del contexto ~/.kube/config
provider "kubernetes" {
    config_path    = local.k8s_config
    config_context = local.cluster_context_name
}

provider "helm" {
  kubernetes {
    config_path    = local.k8s_config
    config_context = local.cluster_context_name
  }
}