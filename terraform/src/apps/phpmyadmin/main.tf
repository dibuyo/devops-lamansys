locals {
    appname             = var.appname
    namespace           = var.namespace
    environment         = var.environment
}

resource "helm_release" "phpmyadmin" {
  
    name       = local.appname
    namespace  = local.namespace

    repository = "https://charts.bitnami.com/bitnami"
    chart      = "phpmyadmin"

    set {
        name  = "db.host"
        value = "mysql.local"
    }

    /*set {
        name  = "ingress.path"
        value = format("/%s", local.appname)
    }*/
}