module "mymodule_network" {
  source = "/home/dev97/taskt/network"
  az=var.az
  vpc_cidrs=var.vpc_cidrs
  subnet_cidrs=var.subnet_cidrs

}
