terraform {
  required_version = ">= 1.0.0"
}

module "vpc" {
  source        = "./modules/vpc"
  vpc_name      = var.vpc_name
  subnet_name   = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  project = var.project
}

module "gke-cluster" {
  source = "./modules/gke"
  node_count = 2
  default_region = var.default_region
  default_zone = var.default_zone
  network = module.vpc.vpc_network_name
  machine_type = var.machine_type
  project = var.project
  cluster_name = var.cluster_name
  pool_name = var.pool_name
}

module "comments-db" {
  source = "./modules/database"
  network = module.vpc.id
  db_instance_name = var.db_instance_name
  database_version = var.database_version
  default_region = var.default_region
  db_instance_tier = var.db_instance_tier
  project = var.project
  db_pass = var.db_pass
  db_user = var.db_user
}

module "artifact-registry" {
  source = "./modules/gcr"
  repository_id = "comment-api_registry"
  default_region = var.default_region
}