variable "az" {
  type    = list(string)
}
variable "vpc_cidrs" {
  type    = list(string)
}
variable "subnet_cidrs" {
  type    = list(string)
}
variable "region_name" {
  type    = string
}

variable "lb_name" {
   type    = string
}

variable "ami_id" {
  type = string
}