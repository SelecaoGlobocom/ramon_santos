terraform {
  required_version = ">= 1.0.0"
}

module "vpc" {
  source        = "./modules/vpc"
  vpc_name      = var.vpc_name
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

  depends_on = [ module.vpc ]
}

module "comments-db" {
  source = "./modules/database"
  network = module.vpc.id
  network_id = module.vpc.vpc_network_name
  db_instance_name = var.db_instance_name
  database_version = var.database_version
  default_region = var.default_region
  db_instance_tier = var.db_instance_tier
  project = var.project
  db_pass = var.DB_PASS
  db_user = var.DB_USER

  depends_on = [ module.vpc ]
}

module "artifact-registry" {
  source = "./modules/gcr"
  repository_id = "comment-api-registry"
  default_region = var.default_region
}

module "kubernetes" {
  source = "./modules/kubernetes"
  monitoring_namespace = var.monitoring_namespace
  api_namespace = var.api_namespace
  DB_HOST = module.comments-db.db_ip
  DB_USER = var.DB_USER
  DB_PASS = var.DB_PASS

  depends_on = [ module.gke-cluster ]
}

module "helm" {
  source = "./modules/helm"
  monitoring_namespace = module.kubernetes.monitoring_namespace

  depends_on = [ module.kubernetes ]
}
