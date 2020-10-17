resource "aws_security_group" "sg_ec2_apache" {
  name        = "${var.name}-${var.env}"
  vpc_id      = aws_vpc.default_ec2.id
  description = "Security Group for Apache Web Servers"

  tags = {
    Name        = "${var.name}-${var.env}"
    app         = var.name
    environment = var.env
    owner       = var.squad
    provisioner = "terraform"

  }
}
resource "aws_security_group_rule" "ingress_tcp_traffic" {
  count       = length(var.tcp_ports)

  type        = "ingress"
  protocol    = "tcp"
  cidr_blocks = var.allowed_cidr_blocks
  from_port   = element(var.tcp_ports, count.index)
  to_port     = element(var.tcp_ports, count.index)

  security_group_id = aws_security_group.sg_ec2_apache.id
}

resource "aws_security_group_rule" "egress_all_traffic" {
  security_group_id = aws_security_group.sg_ec2_apache.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


