resource "aws_elb" "apache_elb" {
    name               = "apache-elb"
    availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
    security_groups    = ["${aws_security_group.sg_apache.id}"]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 4
        timeout             = 3
        target              = "HTTP:80/"
        interval            = 30
    }

    cross_zone_load_balancing   = true
    idle_timeout                = 400
    connection_draining         = true
    connection_draining_timeout = 400

    tags = {
        Name        = "${var.name}-${var.env}"
        app         = var.name
        environment = var.env
        owner       = var.squad
        provisioner = "terraform"
    }
}

resource "aws_lb_cookie_stickiness_policy" "cookie_stickness" {
    name                     = "cookiestickness"
    load_balancer            = aws_elb.apache_elb.id
    lb_port                  = 80
    cookie_expiration_period = 600
}