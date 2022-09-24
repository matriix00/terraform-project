resource "aws_lb" "firstlb" {
  name_prefix               = var.lb_name
  internal           = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.scg_lb.id]
  subnets            = [module.mymodule_network.p1_subnet_id  ,module.mymodule_network.p2_subnet_id]


    # depends_on = [
    #   aws_instance.nginx_server1,
    #   aws_instance.nginx_server2
    # ]

  tags = {
    Environment = "APPLoadBalancer"
  }
}


resource "aws_lb_listener" "alb-listener" {
  
  load_balancer_arn = aws_lb.firstlb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.target1.arn
    type = "forward"
  }
}