output "elb-dns" {
    value = aws_elb.apache_elb.dns_name
}