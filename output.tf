output "vpc_id" {
  value = module.mymodule_network.vpc_id
}

output "p1_subnet_id" {
  value = module.mymodule_network.p1_subnet_id
}

output "p2_subnet_id" {
  value = module.mymodule_network.p2_subnet_id
}

output "pv1_subnet_id" {
  value = module.mymodule_network.pv1_subnet_id
}