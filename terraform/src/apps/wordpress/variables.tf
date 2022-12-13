variable "namespace" {
  type        = string
  description = "Nombre de espacio donde se instalara la aplicación."
  default     = ""
}

variable "app_name" {
  type        = string
  description = "Nombre de la aplicación a instalar."
  default     = "wordpress"
}

variable "replicas" {
  type        = number
  description = "Numero de replicas de los container."
  default     = 1
}

variable "domain" {
    type = string
    description = "Dominio puntero de la URL del wordpress."
}

variable "db_host" {
  type        = string
  description = "Host de la base de datos."
}

variable "db_name" {
  type        = string
  description = "Nombre de la base de datos."
  default     = "wordpress"
}

variable "db_user" {
  type        = string
  description = "Usuario para conectarse a la base de datos."
  default     = "us_wordpress"
}

variable "db_password" {
  type        = string
  description = "Contraseña para conectarse a la base de datos."
  default     = "P@ssw0rd1234!"
}