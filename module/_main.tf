provider "aws" {
  region  = "${var.aws-region}"
  profile = "${var.aws-profile}"
}

resource "aws_instance" "instance" {
  ami           = "${var.instance-ami}"
  instance_type = "${var.instance-type}"

  iam_instance_profile        = "${var.iam-role-name != "" ? var.iam-role-name : ""}"
  key_name                    = "${var.instance-key-name != "" ? var.instance-key-name : ""}"
  associate_public_ip_address = "${var.instance-associate-public-ip}"

  # user_data                   = "${file("${var.user-data-script}")}"
  user_data              = "${var.user-data-script != "" ? file("${var.user-data-script}") : ""}"
  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  subnet_id              = "${aws_subnet.subnet-1.id}"

  tags = {
    Name = "${var.instance-tag-name}"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc-cidr-block}"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc-tag-name}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name = "${var.ig-tag-name}"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet-1-cidr-block}"
  availability_zone = "${var.aws-region}a"

  tags = {
    Name = "${var.subnet-tag-name}"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.subnet-2-cidr-block}"
  availability_zone = "${var.aws-region}b"

  tags = {
    Name = "${var.subnet-tag-name}"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.ig.id}"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = "${aws_subnet.subnet-1.id}"
  route_table_id = "${aws_route_table.rt.id}"
}

# Security Group for EC2 instance
resource "aws_security_group" "sg" {
  name   = "${var.sg-tag-name}"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "22"
    to_port     = "22"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    to_port     = "443"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name = "${var.sg-tag-name}"
  }
}

# Security Group for ALB
resource "aws_security_group" "sg_alb" {
  name   = "${var.sg-alb-tag-name}"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "80"
    to_port     = "80"
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "443"
    to_port     = "443"
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = "0"
    to_port     = "0"
  }

  tags = {
    Name = "${var.sg-alb-tag-name}"
  }
}

# Load Balancer
resource "aws_lb" "alb" {
  name                       = "${var.alb-name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = ["${aws_security_group.sg_alb.id}"]
  subnets                    = ["${aws_subnet.subnet-1.id}", "${aws_subnet.subnet-2.id}" ]
  enable_deletion_protection = false

  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_lb_target_group" "lb_target" {
  name     = "Target-group-engagement-app"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.vpc.id}"
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  // ssl_policy        = "ELBSecurityPolicy-2015-05"
  // certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  }
}

resource "aws_lb_target_group_attachment" "lb_target_attach" {
  target_group_arn = "${aws_lb_target_group.lb_target.arn}"
  target_id        = "${aws_instance.instance.id}"
  port             = 80
}
