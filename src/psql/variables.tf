variable "location" {
  type    = string
  default = "westeurope"
}

variable "prefix" {
  type    = string
  default = "cstar"
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
}

variable "psql_hostname" {
  type = string
}

variable "psql_port" {
  type = string
}

variable "psql_servername" {
  type = string
}

variable "psql_username" {
  type    = string
  default = null
}

variable "psql_password" {
  type    = string
  default = null
}

