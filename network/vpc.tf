resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidrs[0]

}
