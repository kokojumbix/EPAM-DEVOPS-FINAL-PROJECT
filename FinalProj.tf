provider "aws" {
}


// Creating SG to connect via SSH from Jenkins master and give access from internet
resource "aws_security_group" "Web" {
        name    = "Final Project EPAM"
        vpc_id = aws_vpc.main.id


        ingress {
                protocol        = "tcp"
                from_port       = 22
                to_port         = 22
                cidr_blocks     = ["10.0.255.0/24"]
        }


        ingress {

                from_port       = 80
                to_port         = 80
                protocol        = "tcp"
                cidr_blocks     = ["0.0.0.0/0"]
        }

        ingress {

                from_port       = 443
                to_port         = 443
                protocol        = "tcp"
                cidr_blocks     = ["0.0.0.0/0"]
        }

        ingress {

                from_port       = 3306
                to_port         = 3306
                protocol        = "tcp"
                cidr_blocks     = ["172.31.0.0/16"]
        }

        egress {

                from_port       = 3306
                to_port         = 3306
                protocol        = "tcp"
                cidr_blocks     = ["0.0.0.0/0"]
        }

        egress {
                from_port       = 0
                to_port         = 0
                protocol        = "-1"
                cidr_blocks     = ["0.0.0.0/0"]
        }

        tags = {
                name = "Web project"
        }
}

resource "aws_launch_configuration" "Web" {
        name_prefix     = "EPAM-Project-localhorse-"
        image_id        = "ami-00874d747dde814fa"
        instance_type   = "t2.micro"
        security_groups = [aws_security_group.Web.id]
        user_data       = file("user_data.sh")

        associate_public_ip_address = true

        key_name = "FINALTASKSSH"

        lifecycle {
                create_before_destroy = true
        }
}


resource "aws_lb_target_group" "WebLB" {
  name       = "WebLB"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.main.id


  health_check {
    enabled             = true
    port                = 80
    interval            = 10
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 4
  }
}


resource "aws_lb" "WebLB" {
  name               = "WebLB"
  internal           = false
  load_balancer_type = "application"

  subnets = [ aws_subnet.Web-Prod.id, aws_subnet.Web-Test.id ]
}




resource "aws_autoscaling_group" "Web-Test" {
  name                 = "ASG-Test"
  launch_configuration = aws_launch_configuration.Web.name
  min_size             = 1
  max_size             = 1
  min_elb_capacity     = 1
  health_check_type    = "ELB"
  vpc_zone_identifier  = [aws_subnet.Web-Test.id]

  dynamic "tag" {
    for_each = {
        Name = "Web Test Server"
        Status = "Test"
        Owner  = "Mark Chorniy"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_lb_listener" "WebServer" {
  load_balancer_arn = aws_lb.WebLB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.WebProject.arn
  }
}



resource "aws_autoscaling_attachment" "WebProdAttach" {
  autoscaling_group_name = aws_autoscaling_group.Web-Prod.id
  lb_target_group_arn    = aws_lb_target_group.WebProject.arn
}

resource "aws_autoscaling_attachment" "WebTestAttach" {
  autoscaling_group_name = aws_autoscaling_group.Web-Test.id
  lb_target_group_arn    = aws_lb_target_group.WebProjectTest.arn
}


resource "aws_lb_target_group" "WebProject" {
  name     = "lbtargetweb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group" "WebProjectTest" {
  name     = "lbtargetwebtest"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}


resource "aws_autoscaling_group" "Web-Prod" {
  name                 = "ASG-Prod"
  launch_configuration = aws_launch_configuration.Web.name
  min_size             = 1
  max_size             = 1
  min_elb_capacity     = 1
  health_check_type    = "ELB"
  vpc_zone_identifier  = [aws_subnet.Web-Prod.id]

  dynamic "tag" {
    for_each = {
        Name = "Web Prod Server"
        Status = "Prod"
        Owner  = "Mark Chorniy"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_subnet" "Web-Test" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "Web-Test"
  }
}


resource "aws_subnet" "Web-Prod" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Web-Prod"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

}

resource "aws_main_route_table_association" "Web" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.WebRoute.id
}

resource "aws_route_table" "WebRoute" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}
