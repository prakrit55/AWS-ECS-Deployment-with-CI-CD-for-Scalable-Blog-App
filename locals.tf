locals {
    bucket_name = "my-react-frontenddddtteerr"
    ecr_repo_name = "demo-app-ecr-repo"


    bucket1_name = "backend-tf-state-prakriti"
    table_name  = "ccTfDemo"

    demo_app_cluster_name        = "demo-app-cluster"
    availability_zones           = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
    demo_app_task_famliy         = "demo-app-task"
    container_port               = 5000
    demo_app_task_name           = "demo-app-task"
    ecs_task_execution_role_name = "demo-app-task-execution-role"
    
    application_load_balancer_name = "cc-demo-app-alb"
    target_group_name              = "cc-demo-alb-tg"
    
    demo_app_service_name = "cc-demo-app-service"
    apigateway = "api_gateway"
    staging = "api_gateway_staging"
}