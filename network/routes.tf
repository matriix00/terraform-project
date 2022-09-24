
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    name = "public-route-table"
  }
}

resource "aws_route_table_association" "public_ass_routetable1" {
  
 route_table_id = aws_route_table.public_route_table.id
 subnet_id = aws_subnet.my_public_subnet_1.id

}

resource "aws_route_table_association" "public_ass_routetable2" {
  
 route_table_id = aws_route_table.public_route_table.id
 subnet_id = aws_subnet.my_public_subnet_2.id

}

#######igw###################

resource "aws_route" "igw_route" {

    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  

}





###################p1##################################


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    name = "private-route-table"
  }
}

resource "aws_route_table_association" "private_ass_routetable1" {
  
 route_table_id = aws_route_table.private_route_table.id
 subnet_id = aws_subnet.my_private_subnet_1.id

}
resource "aws_route_table_association" "private_ass_routetable2" {
  
 route_table_id = aws_route_table.private_route_table.id
 subnet_id = aws_subnet.my_private_subnet_2.id

}



#############natgw###################

resource "aws_route" "nat1_route" {

    route_table_id = aws_route_table.private_route_table.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_public.id
  

}


