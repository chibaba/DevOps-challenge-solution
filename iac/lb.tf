resource "aws_lb" "nlb" {

  

  depends_on = [time_sleep.wait_120_seconds]

  name               = "nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.public_3.id
    ]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "nlb-listener-443" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front-end-allow-443.arn
  }
}

resource "aws_lb_listener" "nlb-listener-1337" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "1337"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front-end-allow-1337.arn
  }
}

resource "aws_lb_listener" "nlb-listener-8081" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "8081"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front-end-allow-8081.arn
  }
}




resource "aws_lb_target_group" "front-end-allow-1337" {
  name     = "routes-ssh"
  port     = 1337
  protocol = "TCP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group" "front-end-allow-8081" {
  name        = "routes-8081"
  target_type = "alb"
  port        = 8081
  protocol    = "TCP"
  vpc_id      = aws_vpc.main.id
}

resource "aws_lb_target_group" "front-end-allow-443" {
  name        = "routes-443"
  target_type = "alb"
  port        = 443
  protocol    = "TCP"
  vpc_id      = aws_vpc.main.id
}

resource "time_sleep" "wait_120_seconds" {
  provisioner "local-exec" {
    command = "echo -n $(aws elbv2 describe-load-balancers --query 'LoadBalancers[*]'.LoadBalancerArn --output text) > file"
  }



  depends_on = [aws_eks_node_group.nodes_general]

  create_duration = "120s"
}

resource "aws_lb_target_group_attachment" "nlb-attachment-8081" {
  depends_on = [aws_lb.nlb]
  target_group_arn = aws_lb_target_group.front-end-allow-8081.arn
  target_id        = file("file")
  port             = 8081
}

resource "aws_lb_target_group_attachment" "nlb-attachment-443" {
  depends_on = [aws_lb.nlb]
  target_group_arn = aws_lb_target_group.front-end-allow-443.arn
  target_id        = file("file")
  port             = 443
}

resource "aws_lb_target_group_attachment" "nlb-attachment-1337" {
  depends_on = [aws_lb.nlb]
  target_group_arn = aws_lb_target_group.front-end-allow-1337.arn
  target_id        = file("instance")
  port             = 1337
}

output "nlb_id" {
  value       = aws_lb.nlb.dns_name
  description = "nlb dns address"
  # Setting an output value as sensitive prevents Terraform from showing its value in plan and apply.
  sensitive = false
}