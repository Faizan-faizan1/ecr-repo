
## Project Description:

This project demonstrates the implementation of a complete CI/CD pipeline for a Dockerized static web application using Jenkins, Docker, AWS ECR, and EC2. The pipeline automates the build, push, and deployment process, ensuring faster and reliable delivery of code to production.

The project consists of a simple static HTML web page served by an NGINX Docker container. Jenkins is configured to automatically trigger the pipeline whenever new code is pushed to the GitHub repository using a webhook. The Docker image is then pushed to AWS Elastic Container Registry (ECR) and subsequently deployed on an AWS EC2 instance.

## Key Features:

# Automated CI/CD Pipeline:

Code checkout from GitHub

Docker image build

Push to AWS ECR

Deploy to EC2

# Containerization:

Uses Docker and NGINX to serve the static web page

Easy to scale and deploy

# AWS Integration:

Stores Docker images in AWS ECR

Deploys containerized app on EC2 instance

# GitHub Webhook:

Pipeline is triggered automatically on every code push

# Rollback & Idempotency:

Stops and removes existing Docker container before deploying new image

Ensures the latest version is always live

## Technologies Used:

Jenkins – CI/CD automation

Docker – Containerization

AWS ECR – Docker registry

AWS EC2 – Deployment server

GitHub – Source code management

NGINX – Web server



1️⃣ Project Structure

myapp/
├── app/
│   └── index.html        # Your static web page
├── Dockerfile            # Docker build instructions
├── Jenkinsfile           # CI/CD pipeline
└── README.md             # Project documentation



2️⃣ Files

a) app/index.html
b) Dockerfile
c) jenkinsfile



## Steps
1. Push code to GitHub.
2. Jenkins pulls code automatically via webhook.
3. Docker image is built and pushed to AWS ECR.
4. EC2 pulls the latest image and runs the container.

## Requirements
- AWS Account (ECR & EC2)
- Jenkins server
- Docker installed on Jenkins and EC2
- SSH key configured for EC2



3️⃣ Credentials Setup in Jenkins

## AWS Credentials

Go to Jenkins → Manage Jenkins → Credentials → Global → Add Credentials

Type: AWS Credentials

Access Key ID: <your AWS access key>

Secret Access Key: <your AWS secret key>

ID: aws-credentials (optional)

EC2 SSH Key

Go to Jenkins → Manage Jenkins → Credentials → Global → Add Credentials

Type: SSH Username with private key

Username: ec2-user

Private Key: Enter directly or use your .pem file

ID: ec2-key



4️⃣ AWS Setup

a) ECR
  aws ecr create-repository --repository-name jen/ecr --region ap-south-1

b) EC2
Install Docker:

sudo amazon-linux-extras install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user

Ensure Jenkins SSH key can access EC2 (ssh ec2-user@<EC2_PUBLIC_IP>).



5️⃣ GitHub Webhook Setup

  Go to your GitHub repo → Settings → Webhooks → Add webhook

  Payload URL: http://<JENKINS_URL>/github-webhook/

  Content type: application/json

  Secret: optional (you can leave blank)

  Events: Just the push event

  Save webhook.


6️⃣ Jenkins Job Configuration

  Create a Pipeline job

  Definition: Pipeline script from SCM

  SCM: Git

  Repository URL: https://github.com/Faizan-faizan1/ecr-repo.git

  Branch: main

  Script Path: Jenkinsfile

  Enable GitHub hook trigger for GITScm polling


7️⃣ CI/CD Flow

  Developer pushes code to GitHub

  GitHub webhook triggers Jenkins pipeline

  Jenkins pulls code → builds Docker image → pushes to ECR

  Jenkins connects to EC2 → pulls image → runs container

  Web app is live at http://<EC2_PUBLIC_IP>


✅ Optional Improvements

Use Git commit hash for Docker image tags instead of build number.

Add rollback stage if deploy fails.



### Outcome:

Fully automated CI/CD pipeline that eliminates manual deployment steps.

Immediate deployment of updated code on EC2 after every commit.

Demonstrates hands-on experience with Docker, Jenkins, and AWS services.

Add unit tests before building Docker image.
