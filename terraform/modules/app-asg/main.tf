data "aws_availability_zones" "all" {}

# Creating Security Group for EC2 #
resource "aws_security_group" "instance" {
  name   = "swisscom-assignment-instance"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating Launch Configuration #
resource "aws_launch_configuration" "swisscom-assignment" {
  name            = "swisscom-app-launch-configuration"
  image_id        = lookup(var.amis, var.region)
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.instance.id}"]
  associate_public_ip_address = true
  key_name        = var.key_name
  user_data       = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y npm
              sudo apt install git
              sudo git clone https://github.com/ijayasundara/assignment-repo-interview-swisscom.git
              cd /assignment-repo-interview-swisscom/apidemoapp
              nohup sudo npm start &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}

# Creating AutoScaling Group #
resource "aws_autoscaling_group" "swisscom-assignment" {
  name                 = "swisscom-app-autoscaling-group"
  launch_configuration = aws_launch_configuration.swisscom-assignment.id
  vpc_zone_identifier  = var.vpc_zone_identifier
  min_size             = 2
  max_size             = 3
  load_balancers       = ["${aws_elb.swisscom-assignment.name}"]
  health_check_type    = "ELB"
  tag {
    key                 = "Name"
    value               = "swisscom-assignment"
    propagate_at_launch = true
  }
}

# Security Group for ELB #
resource "aws_security_group" "elb" {
  name   = "swisscom-assignment-elb"
  vpc_id = var.vpc_id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating ELB #
resource "aws_elb" "swisscom-assignment" {
  name            = "swisscom-assignment"
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = var.vpc_zone_identifier
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:3000/"
  }
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "3000"
    instance_protocol = "http"
  }
}