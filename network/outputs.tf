output "vpc_id" {
  value = aws_vpc.myvpc.id
}

output "p1_subnet_id" {
  value = aws_subnet.my_public_subnet_1.id
}
output "p2_subnet_id" {
  value = aws_subnet.my_public_subnet_2.id
}

output "pv1_subnet_id" {
  value = aws_subnet.my_private_subnet_1.id
}