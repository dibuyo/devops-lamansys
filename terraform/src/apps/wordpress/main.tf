resource "kubernetes_config_map" "app_config" {
  metadata {
    name = "${local.app_name}-config"
    namespace = local.namespace
  }

  data = {
    ".htaccess" = file("./${path.module}/includes/.htaccess")
    "extra"     = file("./${path.module}/includes/config_extra")
    "php.ini"   = file("./${path.module}/includes/php.ini")
  }
}

resource "kubernetes_namespace" "namespace" {
    metadata {
        
        annotations = {
            name = var.namespace
        }

        labels = {
            "app.kubernetes.io/name" = local.app_name
            "app.kubernetes.io/part-of" = local.namespace
        }

        name = var.namespace
    }
}

resource "kubernetes_persistent_volume_claim" "app_volume_claim" {
    metadata {
        name = "${local.app_name}-pvc"
        namespace = local.namespace
    }
    spec {
        access_modes = ["ReadWriteOnce"]
        
        resources {
            requests = {
                storage = "2Gi"
            }
        }
    }
    
    wait_until_bound = false

    timeouts {
        create = "2m"
    }
}

resource "kubernetes_secret" "app_secrets" {

  metadata {
    name = "${local.app_name}-secrets"
    namespace = local.namespace
  }

  type = "Opaque"

  data = {
    "WORDPRESS_DB_HOST" = local.db_host
    "WORDPRESS_DB_NAME" = local.db_name
    "WORDPRESS_DB_USER" = local.db_user
    "WORDPRESS_DB_PASSWORD" = local.db_password
  }

}

resource "kubernetes_deployment" "app" {

  metadata {
    name = "${local.app_name}"
    labels = {
      app = format("%s", local.app_name)
    }
    namespace = local.namespace
  }

  spec {

    replicas = local.replicas

    selector {
      match_labels = {
        app = format("%s", local.app_name)
      }
    }

    template {

        metadata {
            labels = {
                app = format("%s", local.app_name)
            }
        }

        spec {

            container {
                image = format("%s", local.app_name)
                name  = format("%s", local.app_name)

                port {
                    container_port = 80
                }

                env_from {
                    secret_ref {
                        name = kubernetes_secret.app_secrets.metadata[0].name
                    }
                }

                env {
                    name = "WORDPRESS_CONFIG_EXTRA"
                    value_from {
                        config_map_key_ref {
                            name = kubernetes_config_map.app_config.metadata[0].name
                            key = "extra"
                        }
                    }
                }

                volume_mount {
                    mount_path = "/var/www/html"
                    name = "app-pvc"
                }

                volume_mount {
                    mount_path = "/var/www/disk"
                    name = "app-pvc"
                }

                volume_mount {
                    mount_path = "/var/www/html/.htaccess"
                    name = "app-config"
                    sub_path = ".htaccess"
                }

                volume_mount {
                    mount_path = "/usr/local/etc/php/conf.d/uploads.ini"
                    name = "app-config"
                    sub_path = "php.ini"
                }
            }

            volume {
                name = "app-pvc"
                persistent_volume_claim {
                    claim_name = kubernetes_persistent_volume_claim.app_volume_claim.metadata[0].name
                } 
            }

            volume {
                name = "app-config"
                config_map {
                    name = kubernetes_config_map.app_config.metadata[0].name
                }
            }

        }

    }
  }

  timeouts {
      create = "2m"
      delete = "2m"
  }
}

resource "kubernetes_service" "app_service" {
  metadata {
    name = format("%s", local.app_name)
    
    namespace = local.namespace
  }

  spec {
    selector = {
      app = kubernetes_deployment.app.spec.0.template.0.metadata[0].labels.app
    }
    
    port {
      name        = "http"
      port        = 80
      target_port = 80
    }
    
    type = "ClusterIP"
  }
}