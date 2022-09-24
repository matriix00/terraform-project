
resource "aws_nat_gateway" "nat_public" {
  allocation_id = aws_eip.ip1.id
  subnet_id     = aws_subnet.my_public_subnet_1.id

  tags = {
    Name = "gw NAT1"
  }


  depends_on = [aws_eip.ip1]
}


resource "aws_eip" "ip1" {
  
}
