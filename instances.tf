resource "aws_instance" "nginx_server1" {
count = 1 
 ami           = var.ami_id
  instance_type = "t2.micro"
  tags = {
   Name = "Server ${count.index}"
 }
  # VPC
  subnet_id = module.mymodule_network.p2_subnet_id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  # the Public SSH key
  key_name = aws_key_pair.aws-key.id
  # nginx installation
  # storing the nginx.sh file in the EC2 instnace
  provisioner "file" {
    source      = "nginx.sh"
    destination = "/tmp/nginx.sh"
  }

  # Setting up the ssh connection to install the nginx server
  # Exicuting the nginx.sh file
  # Terraform does not reccomend this method becuase Terraform state file cannot track what the scrip is provissioning
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/nginx.sh",
      "sudo /tmp/nginx.sh"
    ]
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("${"/home/dev97/.ssh/id_rsa"}")
  }
  }




  
  # #######################################
  # resource "aws_instance" "nginx_server2" {
  # ami           = var.ami_id
  # instance_type = "t2.micro"
  # tags = {
  #   Name = "nginx_server2"
  # }
  # # VPC
  # subnet_id = module.mymodule_network.p2_subnet_id
  # # Security Group
  # vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  # # the Public SSH key
  # key_name = aws_key_pair.aws-key.id
  # # nginx installation
  # # storing the nginx.sh file in the EC2 instnace
  # provisioner "file" {
  #   source      = "nginx.sh"
  #   destination = "/tmp/nginx.sh"
  # }
  # # Exicuting the nginx.sh file
  # # Terraform does not reccomend this method becuase Terraform state file cannot track what the scrip is provissioning
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo chmod +x /tmp/nginx.sh",
  #     "sudo /tmp/nginx.sh"
  #   ]
  # }
  # # Setting up the ssh connection to install the nginx server
  # connection {
  #   type        = "ssh"
  #   host        = self.public_ip
  #   user        = "ubuntu"
  #   private_key = file("${"/home/dev97/.ssh/id_rsa"}")
  # }
  # }


  ####################bastion########################
resource "aws_instance" "bastion" {
  depends_on = [
    aws_instance.nginx_server1
  ]
  ami           = var.ami_id
  instance_type = "t2.micro"
  tags = {
    Name = "bastion_server"
  }
  # VPC
  subnet_id = module.mymodule_network.p1_subnet_id
    # Security Group
  vpc_security_group_ids = ["${aws_security_group.BH-SG.id}"]
  # the Public SSH key
  key_name = aws_key_pair.aws-key.id
 provisioner "local-exec" {
    command = "echo ${self.public_ip} "
  }
  # Setting up the ssh connection to install the nginx server
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("${"/home/dev97/.ssh/id_rsa"}")
  }
  }



  ###################### private  ec2 ################################
resource "aws_instance" "webapp_server" {

  depends_on = [
    aws_instance.nginx_server1
  ]
  ami           = var.ami_id
  instance_type = "t2.micro"
  tags = {
    Name = "webapp_server"
  }
  # VPC
  subnet_id = module.mymodule_network.pv1_subnet_id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.scg_webapp.id}"]
  # the Public SSH key
  key_name = aws_key_pair.aws-key.id
  # docker installation
  provisioner "file" {
    source      = "webapp.sh"
    destination = "/tmp/webapp.sh"
  }
  # Exicuting the nginx.sh file
  # Terraform does not reccomend this method becuase Terraform state file cannot track what the scrip is provissioning
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/webapp.sh",
      "sudo /tmp/webapp.sh"
    ]
  }
  # Setting up the ssh connection to install the nginx server
  connection {
    type        = "ssh"
    host        = aws_instance.nginx_server1[0].public_ip
    user        = "ubuntu"
    private_key = file("${"/home/dev97/.ssh/id_rsa"}")
  }
  }