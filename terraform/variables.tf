#### Cloud variables #### 

variable "project" {
  type    = string
  default = "sandbox-387113"
}

variable "credentials" {
  type    = string
}

variable "default_region" {
  type = string
  default = "us-central1"
}

variable "default_zone" {
  type = string
  default = "us-central1-a"
}


#### DB Variables ####

variable "db_instance_tier" {
  type = string
  default = "db-f1-micro"
}

variable "database_version" {
  type = string
  default = "POSTGRES_14"
}

variable "db_instance_name" {
  type = string
  default = "comments-db"
}

variable "db_user" {
  type = string
}

variable "db_pass" {
  type = string
}


#### VPC Variables #### 

variable "ip_cidr_range" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnet_name" {
  type = string
  default = "comment-subnet"
}

variable "vpc_name" {
  type = string
  default = "comment-test"
}

#### GKE Variables ####

variable "machine_type" {
  type = string
  default = "e2-medium"
}

variable "cluster_name" {
  type    = string
  default = "desafio-globo"
}
variable "pool_name" {
  type    = string
  default = "desafio-pool"
}

variable "monitoring_namespace" {
  type = string
  default = "monitoring"
}

variable "api_namespace" {
  type = string
  default = "comment-api"
}