## Introduction
A complete project configuring Django to run on AWS ECS with RDS(postgres) backup.
This projects includes development and production version of dockerfile and docker-compose file. for production environments, add on nginx serving static and media files, reverse-proxying gunicorn as production server.  

This fully functioning blog app is deveopled by corey schafer using django backend for his youtube tutorial:
https://www.youtube.com/watch?v=UmljXZIypDc&list=PL-osiE80TeTtoQCKZ03TU5fNfx2UY6U4p
https://github.com/CoreyMSchafer/code_snippets/tree/master/Django_Blog/12-Password-Reset
This app supports mutiple user authentication, password reset.

## Prerequiste
1.a configured aws IAM account (acess key/secret key) with admin previlleges
```bash
$ export AWS_ACCESS_KEY_ID="YOUR_AWS_ACCESS_KEY_ID"
$ export AWS_SECRET_ACCESS_KEY="YOUR_AWS_SECRET_ACCESS_KEY"
```
2. a workable hosted zone and domain name in Route53 in your AWS account, in 11_route53.tf, search rfexpert.net, replace all with your registered domain name
3. a issued SSL certificate in ACM linked to workable domain name, in variables.tf, search certificate_arn, update with your issued SSL certificate that is linked to your registered domain name
4. in variables.tf, search email, update with your email/password that are used for server sending password reset eamil to users
5. to make things simple, set default region to ap-southeast-2, it's been setup in variables.tf
6. in variable.tf, search rds_password, set RDS(postgres) password

My terraform version: Terraform v0.13.3


## Give it a try
```bash
git clone https://github.com/fan-bingbing/django_ecs_terraform.git
cd django_ecs_terraform
```
Before building image, update your email and password in both .env.dev and .env.prod
EMAIL_USER=***
EMAIL_PASS=***
This is for the same purpose as Prerequiste 4. 

Once email setting is done, run following commands to prepare images with correct ECR tag
```bash
docker build -t <your-aws-account-number>.dkr.ecr.ap-southeast-2.amazonaws.com/django-app:latest .
docker build -t <your-aws-account-number>.dkr.ecr.ap-southeast-2.amazonaws.com/nginx:latest .
$(aws ecr get-login --region ap-southeast-2 --no-include-email)
docker push <your-aws-account-number>.dkr.ecr.ap-southeast-2.amazonaws.com/django-app:latest
docker push <your-aws-account-number>.dkr.ap-southeast-2.amazonaws.com/nginx:latest
```
Spin up AWS resource
```bash
cd terraform
ssh-keggen -i mykey
terraform plan
terraform apply
```
following resource will be created in your AWS account:
Networking:
VPC
Public and private subnets
Routing tables
Internet Gateway
Key Pairs
Security Groups
Load Balancers, Listeners, and Target Groups
IAM Roles and Policies
ECS:
Task Definition (with multiple containers)
Cluster
Service
Launch Config and Auto Scaling Group
RDS
Health Checks and Logs
ROUTE53
A type record
Valid certificate link


visit www.your-domain.com

## Clean up
```bash
cd terraform
terraform destroy
```

## command for development 
```bash
docker-compose up -d 
docker-compose up -d --build
docker-compose logs -f
docker-compose down -v
```

## manage containers
```bash
docker exec -it <container-id> python manage.py migrate
docker exec -it <container-id> sh && manage.py createsuperuser
```