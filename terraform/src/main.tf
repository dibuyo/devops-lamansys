locals{
    env = "sandbox"
    cluster_context_name = var.cluster_context_name
    k8s_config = var.k8s_config
    domain = "local"
    wordpress = format("wordpress.%s", local.domain)
    jenkins = format("jenkins.%s", local.domain)
}

module "wordpress" {
    source          = "./apps/wordpress"
    namespace       = "wordpress"
    domain          = local.wordpress
    replicas        = 1
    db_host         = "mysql.database.svc.cluster.local."
    db_name         = "wpdb"
    db_user         = "curso"
    db_password     = "p@ssw0rd2022"
}

module "jenkins" {
  source = "./apps/jenkins"

  environment = local.env
  namespace   = "automation"
  appname     = "jenkins"
  domain      = local.jenkins
}

module "phpmyadmin" {  
  source = "./apps/phpmyadmin"
  
  environment       = local.env
  appname           = "phpmyadmin"
  namespace         = "wordpress"
}