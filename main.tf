module "fc3-vpc" {
  source             = "./modules/vpc"
  prefix             = var.prefix
  availability_zones = ["us-east-1a", "us-east-1b"]
}
