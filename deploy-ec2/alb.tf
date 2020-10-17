resource "aws_lb" "apache_alb" {
  name                        = "apache-alb"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = [aws_security_group.sg_ec2_apache.id]
  subnets                     = data.aws_subnet_ids.public_subnets.ids
  idle_timeout                = 400

  tags = {
    Name        = "${var.name}-${var.env}"
    app         = var.name
    environment = var.env
    owner       = var.squad
    provisioner = "terraform"

  }
}

resource "aws_lb_target_group" "apache_tg" {
  name     = "apache-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.default_ec2.id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.apache_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.apache_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "apache_tg" {
  target_group_arn = aws_lb_target_group.apache_tg.arn
  target_id        = aws_instance.apache_webserver.id
  port             = 80
}
