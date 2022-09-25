resource "aws_security_group" "ssh-allowed" {
    vpc_id = module.mymodule_network.vpc_id
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Created an inbound rule for SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22

    # Here adding tcp instead of ssh, because ssh in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Created an inbound rule for webserver access!
  ingress {
    description = "HTTP for webserver"
    from_port   = 80
    to_port     = 80

    # Here adding tcp instead of http, because http in part of tcp only!
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }

  ##### bastion host #####
  resource "aws_security_group" "BH-SG" {

  

  description = "bastion host"
  name = "bastion-host-sg"
  vpc_id = module.mymodule_network.vpc_id

  # Created an inbound rule for Bastion Host SSH
  ingress {
    description = "Bastion Host SG"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from Bastion Host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



  ################qdsa ###############3
  resource "aws_security_group" "scg_lb" {
    vpc_id = module.mymodule_network.vpc_id
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  }

  ################# security group for webapp #########################

    resource "aws_security_group" "scg_webapp" {
      depends_on = [
        aws_security_group.ssh-allowed,
        aws_security_group.BH-SG
      ]
    vpc_id = module.mymodule_network.vpc_id
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
    ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    security_groups = [aws_security_group.ssh-allowed.id]
     // Ideally best to use your machines' IP. However if it is dynamic you will need to change this in the vpc every so often. 
  }

  ingress {
    description = "webapp Access"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = [aws_security_group.ssh-allowed.id]
    cidr_blocks = ["10.0.0.0/16"]

  }
  }