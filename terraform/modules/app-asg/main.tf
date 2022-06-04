data "aws_availability_zones" "all" {}

### Creating Security Group for EC2
resource "aws_security_group" "instance" {
  name = "swisscom-assignment-instance"
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
## Creating Launch Configuration
resource "aws_launch_configuration" "swisscom-assignment" {
  image_id               = "${lookup(var.amis,var.region)}"
  instance_type          = "t2.micro"
  security_groups        = ["${aws_security_group.instance.id}"]
  key_name               = "${var.key_name}"
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  lifecycle {
    create_before_destroy = true
  }
}
## Creating AutoScaling Group
resource "aws_autoscaling_group" "swisscom-assignment" {
  launch_configuration = "${aws_launch_configuration.swisscom-assignment.id}"
  availability_zones = "${data.aws_availability_zones.all.names}"
  min_size = 2
  max_size = 10
  load_balancers = ["${aws_elb.swisscom-assignment.name}"]
  health_check_type = "ELB"
  tag {
    key = "Name"
    value = "swisscom-assignment"
    propagate_at_launch = true
  }
}
## Security Group for ELB
resource "aws_security_group" "elb" {
  name = "swisscom-assignment"
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

### Creating ELB
resource "aws_elb" "swisscom-assignment" {
  name = "swisscom-assignment"
  security_groups = ["${aws_security_group.elb.id}"]
  availability_zones = "${data.aws_availability_zones.all.names}"
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:8080/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "8080"
    instance_protocol = "http"
  }
}