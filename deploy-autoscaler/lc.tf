resource "aws_launch_configuration" "apache_webserver" {
    image_id        = data.aws_ami.ubuntu_latest.id
    instance_type   = var.instance_type
    user_data       = file("scripts/bootstrap.sh")
    security_groups = [aws_security_group.sg_apache.id]

    lifecycle {
        create_before_destroy = true
    }
}