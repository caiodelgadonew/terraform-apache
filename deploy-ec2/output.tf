output "aws_lb" {
    value = aws_lb.apache_alb.dns_name
}