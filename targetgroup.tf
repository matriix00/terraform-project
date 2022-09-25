# resource "aws_lb_target_group" "target1" {
#   name     = "tf-example-lb-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.mymodule_network.vpc_id
#   health_check {
#     interval = 10
#     path = "/"
#     protocol = "HTTP"
#     port = 80
#     timeout = 5
#     healthy_threshold = 5
#     unhealthy_threshold = 2

#   }
# }


# resource "aws_lb_target_group_attachment" "target_attach1" {
#   target_group_arn = aws_lb_target_group.target1.arn
#   target_id        = aws_instance.nginx_server1.id
#   port             = 80
# }
# resource "aws_lb_target_group_attachment" "target_attach2" {
#   target_group_arn = aws_lb_target_group.target1.arn
#   target_id        = aws_instance.nginx_server2.id
#   port             = 80
# }

# ###################################################################