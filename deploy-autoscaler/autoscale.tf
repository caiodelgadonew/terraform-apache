resource "aws_autoscaling_group" "scale_group" {
    launch_configuration = aws_launch_configuration.apache_webserver.name
    availability_zones   = ["${var.region}a", "${var.region}b", "${var.region}c"]
    min_size             = 1
    max_size             = 3
    enabled_metrics      = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
    metrics_granularity  = "1Minute"
    load_balancers       = ["${aws_elb.apache_elb.id}"]
    # target_group_arns    = aws_lb_target_group.apache_tg.arn
    health_check_type    = "ELB"
    tag {
        key                 = "Name"
        value               = "apache_webserver000"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_policy" "autoscalingpolicy" {
    name                   = "terraform-autoscalepolicy"
    scaling_adjustment     = 1
    adjustment_type        = "ChangeInCapacity"
    cooldown               = 300
    autoscaling_group_name = aws_autoscaling_group.scale_group.name
}

resource "aws_autoscaling_policy" "autoscalepolicy-down" {
    name                   = "terraform-autoscalepolicy-down"
    scaling_adjustment     = -1
    adjustment_type        = "ChangeInCapacity"
    cooldown               = 300
    autoscaling_group_name = aws_autoscaling_group.scale_group.name
}