resource "aws_ecs_cluster" "demo_app_cluster" {
    name = var.demo_app_cluster_name
}


resource "aws_ecs_task_definition" "demo_app_task" {
    family                   = var.demo_app_task_famliy
    container_definitions    = <<DEFINITION
    [
    {
        "name": "${var.demo_app_task_name}",
        "image": "${var.ecr_repo_url}:latest",
        "essential": true,
        "portMappings": [
        {
            "containerPort": ${var.container_port},
            "hostPort": ${var.container_port}
        }
        ],
        "memory": 512,
        "cpu": 256
    }
    ]
    DEFINITION
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    memory                   = 512
    cpu                      = 256
    execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_iam_role" "ecs_task_execution_role" {
    name               = var.ecs_task_execution_role_name
    assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
    role       = aws_iam_role.ecs_task_execution_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
