module "vpc" {
  source = "./modules/vpc"
  prefix = var.prefix
}

module "eks" {
  source       = "./modules/eks"
  prefix       = var.prefix
  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.subnet_ids
  vpc_id       = module.vpc.vpc_id
  desired_size = var.desired_size
  max_size     = var.max_size
  min_size     = var.min_size

}
