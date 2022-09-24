#------------------public subnets------------------------------
resource "aws_subnet" "my_public_subnet_1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_cidrs[0]
  availability_zone = var.az[0]
  map_public_ip_on_launch =  true
  tags = {
    Name = "tf-public-subnet1"
  }
}
resource "aws_subnet" "my_public_subnet_2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_cidrs[1]
  availability_zone = var.az[1]
  map_public_ip_on_launch =  true

  tags = {
    Name = "tf-public-subnet2"
  }
}

#---------------private subnets---------------------

resource "aws_subnet" "my_private_subnet_1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_cidrs[2]
  availability_zone = var.az[0]

  tags = {
    Name = "tf-private-subnet1"
  }
}

resource "aws_subnet" "my_private_subnet_2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = var.subnet_cidrs[3]
  availability_zone = var.az[1]

  tags = {
    Name = "tf-private-subnet2"
  }
}   