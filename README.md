# AWS infra to deploy application in ecs with Terraform

Diagram

![alt text](<media/Screenshot (299).png>)



# Introduction

Welcome to the application deployment project with AWS! 
We will walk thorugh the process of setting up a robust three tier architecture on AWS using s3, ecs, loadbalancer, mongodb, etc.
This project aims to provide hands-on experience in deploying, securing, and monitoring a scalable application environment.This is the first part of the project where we will create the architecture and for the later part, the ci/cd will be discussed here ->

# Project Overview :

In this project, we will cover the following key points:

    1. IAM user setup : Create user with necessary permissions to facilitate deployment and management activities. Store the aws credentials(aws access key, and aws secret access key), which will later be used to configure the AWS cli to create the whole architecture.

    2. Infrastructure as a Code(IaC) : Install Terraform and AWS cli to setup the Infra.

    3. Terraform Commands: Use terraform commands such as terraform init, terraform plan, terraform destroy to create and destroy the infra.

# Prequisite

Before configuring the services, ensure you are having the following credentials in place:
    * An AWS account with the necessary permissions to create resources.
    * Terraform and AWS CLI installed on your local computer.
    * A familiarity with few aws services, terraform usecases.


Step 1: Clone the repo using 
    `git clone `

Step 2: Log in to your aws account, search for IAM
    * go to user
    * Write the name of your user (no need to put console access, since you will only access the cli)
    * select `attach the policies directly`
    * for demo purpose we can give `AdministratorAccess` but not suggested for production
    * Create the user, then you will be returned to the user dashboard, press the user name
    * in the right hand side, tap the `Create access key`
    * now select the `command line interface (CLI)` to create the keys (dont forget to tap the confirmation below)
    * now use the accss keys to configure the user in the cli

Step 3: Install the terraform and aws cli v2, configure them in the environmental variables (you will find a lot of resource to figure this out)

Step 4: Considering you have already installed the above resources,
    * write `aws configure` and give the previously created aws access key and secret access key to save the user, you can also give the region where the resource to be created.

Step 5: Move to the repo which you have cloned previously.

Step 6: This step to be performed in accordance to the next part of the        project, move to the second repository and clone the repo and  create you own ci/cd in your repo.

Step 7: Considering you are done with `step 6`, lets create the infra.
    * Let us first create the `ECR private repo` and `the s3 where the frontend to be hosted`.

    * comment the whole `ECS module in main.tf`

    * now in the cli write `terraform init` to initialize the tf code, it will take bit of time to configure

    * now tap `terraform plan`, that will show the resources that will get created

    * now tap `terraform apply --auto-approve`, after a while theecr and s3 bucket will get created.

    * now move to the other repo you have created and make a small change in the code such as a space at the end of the lines(you can directly create the change in github or can clone the repo and change it by using the below commands)

    * now move to the cli space of the repo cloned, use command `git add`, `git commit -m "any message"`, `git push` to push the code to your repository, this will run the automated ci/cd pipeline and will push the backend image to `ECR` and frontend build `to the S3` bucket.

    * now return to the directory where terraform code is present, un-comment the `ECS module`

    * in the cli of the repo, tap `terraform init`, `terraform plan`, `terraform apply --auto approve`, to create the ecs cluster and other things.

    * after a while, you will find that the application loadbalancer, ECS service, task are created

    * now take the url of the loadbalancer and write it in the repo where you have kept you code (in `my-blog-app/src/api/api.tsx`) and replace it in `API_URL`

    * save the changes, add the changes, commit the changes and push it with the above git commands mentioned; wait until the ci/cd has been completed.

    * go to the aws s3, `frontend` bucket and check below the properties section, you will find the url where the frontend is hosted.

    * now in your browser, paste the url to get the application.

    * after you are done with the application, run `terraform destroy --auto-approve` to destroy the entire infra. 

# Explanation

Now we get into a brief explanation of the infrastructure

1. To begin with we first create only the S3 bucket and ECR private registry, by commenting out the ECS code in main.

2. We ran the ci/cd process by changing the code in order to push the docker image with the proper tags to the ECR, and the frontend build code to the S3 bucket.

3. Now we ran the terraform code by un-commenting the ECS module in main.tf. It helps the ECS to track the image in ECR and create the services and tasks from the image pushed.

3. The ECS uses fargate (one of the serverless services in aws) to run the containers. In this case we configure a loadbalancer which is to be hosted in two availability zones. For this we created two vpc with two subnets.

4. The loadbalancer is configured with a security group, and registered in the ECS.

5. So that, when we access the loadbalancer url we can request to the backend services deployed in ecs.

6. The database is configured from outside the aws, we are using the atlas for mongodb cluster for data storage. We can use documentDB here for the data storage, which is a aws managed database service like mongodb.







