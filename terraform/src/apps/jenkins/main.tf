locals{
    app_name    = var.appname
    appname     = var.appname
    namespace   = var.namespace
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

resource "kubernetes_config_map" "config" {
    metadata {
        name = "${var.appname}-config"
        namespace = var.namespace
    }

    data = {
        "config.xml" = file("${path.module}/config/config.xml")
        "jenkins.model.JenkinsLocationConfiguration.xml" = file("./${path.module}/config/jenkins.model.JenkinsLocationConfiguration.xml")
        "jenkins.CLI.xml" = file("${path.module}/config/jenkins.CLI.xml")
        "apply_config.sh" = file("${path.module}/config/apply_config.sh")
        "plugins.txt" = file("${path.module}/config/plugins.txt")
    }
}

resource "kubernetes_persistent_volume_claim" "volume_claim" {

    metadata {
        name = "${var.appname}-pvc"
        namespace = var.namespace
    }

    spec {
        access_modes = ["ReadWriteOnce"]
        
        resources {
            requests = {
                storage = "20Gi"
            }
        }
    }

    wait_until_bound = false

    timeouts {
        create = "2m"
    }
}

resource "kubernetes_service_account" "jenkins" {
  metadata {
    name      = local.app_name
    namespace =  kubernetes_namespace.namespace.metadata[0].name
  }

  automount_service_account_token = true
}

resource "kubernetes_role" "rol" {
  metadata {
    name = "${local.namespace}-rol"
  }

  rule {
    api_groups     = [""]
    resources      = ["pods", "pods/exec", "pods/log", "configmaps", "secrets", "events"]
    verbs          = ["*"]
  }
}

resource "kubernetes_cluster_role_binding" "jenkins_cluster_role_binding" {
  metadata {
    name = "${local.appname}-schedule-agents"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "${local.namespace}-rol"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "jenkins"
    namespace = local.namespace
  }
}

resource "kubernetes_service" "service_agent" {

    metadata {
        name = "${var.appname}-agent"
        namespace = var.namespace
        labels = {
            app = var.appname
        }
    }

    spec {
        selector = {
            app = kubernetes_deployment.deploy.spec.0.template.0.metadata[0].labels.app
        }
        
        port {
            name        = "slavelistener"
            port        = 50000
            target_port = 50000
        }
        
        type = "ClusterIP"
    }
}

resource "kubernetes_service" "service" {

    metadata {
        name = var.appname
        namespace = var.namespace
        labels = {
            app = var.appname
        }
    }

    spec {
        selector = {
            app = kubernetes_deployment.deploy.spec.0.template.0.metadata[0].labels.app
        }
        
        port {
            name        = "http"
            port        = 8080
            target_port = 8080
        }
        
        type = "ClusterIP"
    }
}

resource "kubernetes_deployment" "deploy" {
    metadata {
        name = var.appname
        namespace = var.namespace
        labels = {
            app = var.appname
        }
    }

    spec {

        replicas = 1

        selector {
            match_labels = {
                app = var.appname
            }
        }

        template {

            metadata {
                labels = {
                    app = var.appname
                }
            }

            spec {
                service_account_name = "jenkins" 
                
                init_container {
                    name  = "disable-thp"
                    image = "busybox"

                    command = [ "sh", "-c", "chown -R 1000:1000 /var/jenkins_home/" ]

                    volume_mount {
                        mount_path = "/var/jenkins_home"
                        name = "jenkins-home"
                        read_only = false
                    }
                }

                container {
                    image = "jenkins/jenkins:lts"
                    image_pull_policy = "Always"
                    name  = var.appname

                    args = [ "--argumentsRealm.passwd.$(ADMIN_USER)=$(ADMIN_PASSWORD)",  "--argumentsRealm.roles.$(ADMIN_USER)=admin" ]

                    port {
                        container_port = 6379
                    }

                    env {
                        name = "JAVA_OPTS"
                        value = ""
                    }

                    env {
                        name = "JENKINS_OPTS"
                        value = ""
                    }

                    env {
                        name = "JENKINS_SLAVE_AGENT_PORT"
                        value = "50000"
                    }

                    env {
                        name = "ADMIN_PASSWORD"
                        value = "W31t2022!"
                    }

                    env {
                        name = "ADMIN_USER"
                        value = "devops"
                    }

                    port {
                        container_port = 8080
                        name = "http"
                    }

                    port {
                        container_port = 50000
                        name = "slavelistener"
                    }

                    /*

                    resources {
                        limits = {
                            cpu = "0.1"
                        }
                    }*/

                    volume_mount {
                        mount_path = "/tmp"
                        name = "tmp"
                    }

                    volume_mount {
                        mount_path = "/var/jenkins_home"
                        name = "jenkins-home"
                        read_only = false
                    }

                    volume_mount {
                        mount_path = "/var/jenkins_config"
                        name = "jenkins-config"
                        read_only = true
                    }

                    volume_mount {
                        mount_path = "/usr/share/jenkins/ref/plugins/"
                        name = "plugin-dir"
                        read_only = false
                    }

                    volume_mount {
                        mount_path = "/usr/share/jenkins/ref/secrets/"
                        name = "secrets-dir"
                        read_only = false
                    }

                    volume_mount {
                        name = "backups"
                        mount_path = "/var/backups"
                    }
                }

                volume {
                    name = "plugins"
                    empty_dir {}
                }

                volume {
                    name = "plugin-dir"
                    empty_dir {}
                }

                volume {
                    name = "secrets-dir"
                    empty_dir {}
                }

                volume {
                    name = "tmp"
                    empty_dir {}
                }

                volume {
                    name = "backups"
                    host_path {
                        path = "/var/backups/jenkins"
                    }
                }

                
                volume {
                    name = "jenkins-config"
                    config_map {
                        name = kubernetes_config_map.config.metadata[0].name
                    }
                }

                volume {
                    name = "jenkins-home"
                    persistent_volume_claim {
                        claim_name = kubernetes_persistent_volume_claim.volume_claim.metadata[0].name
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