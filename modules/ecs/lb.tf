resource "aws_alb" "test" {
    name               = var.application_load_balancer_name
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    enable_deletion_protection = false
    subnet_mapping {
        subnet_id = aws_subnet.pulbic-1.id
    }
    subnet_mapping {
        subnet_id = aws_subnet.pulbic-2.id
    }

    tags = {
    Environment = "production"
    }
}

resource "aws_alb_target_group" "target_group" {
    name        = var.target_group_name
    port        = var.container_port
    protocol    = "HTTP"
    target_type = "ip"
    vpc_id      = aws_vpc.main.id
}

resource "aws_alb_listener" "listener" {
    load_balancer_arn = aws_alb.test.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
    }
}

resource "aws_security_group" "alb_sg" {
    vpc_id      = aws_vpc.main.id
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  // Define ingress rules as needed
}