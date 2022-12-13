variable "k8s_config" {
  type        = string
  description = "Path del Archivo de configuración de Kubernetes"
  default = "~/.kube/config"
}

variable "cluster_context_name" {
  type        = string
  description = "Nombre del contexto del Cluster definida en el archivo de Kubernetes."
}