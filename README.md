# ECS Fargate Nginx Server Deployment with ALB and EFS

A highly available Nginx web server deployment on AWS ECS Fargate with Application Load Balancer and Elastic File System for persistent storage, provisioned using Terraform.

## Architecture Overview

This project implements a production-ready, highly available architecture with the following components:

- **ECS Fargate Cluster** - Serverless container orchestration spread across multiple availability zones
- **Application Load Balancer (ALB)** - Internet-facing load balancer for traffic distribution
- **Elastic File System (EFS)** - Shared persistent storage across containers
- **Custom VPC** - Multi-AZ VPC with public subnets
- **Security Groups** - Layered security for ALB, ECS tasks, and EFS access
- **IAM Roles** - Proper permissions for ECS task execution and EFS access

## Features

-  High availability across multiple availability zones (us-west-2a, us-west-2b)
-  Auto-scaling and self-healing ECS service
-  Persistent storage with EFS mounted at `/mnt/data`
-  Custom Nginx Docker image with HTML content
-  Secure network architecture with properly configured security groups
-  Infrastructure as Code using Terraform
-  Internet-facing Application Load Balancer for traffic distribution

## Prerequisites

- AWS Account with appropriate permissions
- Terraform installed (v1.0+)
- Docker installed
- AWS CLI configured with credentials

## Architecture Components

### Network Configuration

- **VPC CIDR**: 10.0.0.0/16
- **Public Subnet A**: 10.0.1.0/24 (us-west-2a)
- **Public Subnet B**: 10.0.2.0/24 (us-west-2b)
- **Internet Gateway**: Attached to VPC
- **Route Table**: Routes 0.0.0.0/0 to Internet Gateway

### Security Groups

**ALB Security Group:**
- Ingress: Port 80 from 0.0.0.0/0
- Egress: All traffic

**ECS Task Security Group:**
- Ingress: Port 80 from ALB Security Group
- Egress: All traffic

**EFS Security Group:**
- Ingress: Port 2049 from ECS Security Group
- Egress: All traffic

### ECS Configuration

- **Cluster Name**: Task5-ECS-Cluster-Zaeem
- **Service Name**: Task5-ECS-Service-Zaeem
- **Launch Type**: Fargate
- **Desired Count**: 2 tasks
- **CPU**: 256
- **Memory**: 512 MB
- **Container Port**: 80

## Deployment Steps

### 1. Clone the Repository

```bash
git clone <repository-url>
cd <repository-name>
```

### 2. Build and Push Docker Image

```bash
# Create ECR repository
aws ecr create-repository --repository-name <your-repo-name> --region us-west-2

# Authenticate Docker to ECR
aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-west-2.amazonaws.com

# Build the Docker image
docker build -f Dockerfile -t <your-repo-name> .

# Tag the image
docker tag <your-repo-name>:latest <account-id>.dkr.ecr.us-west-2.amazonaws.com/<your-repo-name>:latest

# Push to ECR
docker push <account-id>.dkr.ecr.us-west-2.amazonaws.com/<your-repo-name>:latest
```

### 3. Deploy Infrastructure with Terraform

```bash
# Initialize Terraform
terraform init

# Review the deployment plan
terraform plan

# Apply the configuration
terraform apply
```

### 4. Access the Application

After successful deployment, access your Nginx server using the ALB DNS name:

```
http://<alb-dns-name>
```

The ALB DNS name can be found in the AWS Console or Terraform outputs.

## IAM Permissions

### Task Execution Role
- `AmazonECSTaskExecutionRolePolicy` (managed policy)

### Task Role
- `elasticfilesystem:ClientRootAccess`
- `elasticfilesystem:ClientWrite`
- `elasticfilesystem:ClientMount`

## Verification and Testing

### Availability Testing

To verify high availability:

1. Delete one of the running tasks from the ECS console
2. The ECS service will automatically detect the desired state mismatch
3. A new task will be provisioned automatically to maintain the desired count of 2

### Scalability

The ECS service can be scaled by updating the `desired_count` parameter in the Terraform configuration.

## Important Notes

⚠️ **DNS Resolution**: When using a custom VPC, ensure DNS hostnames and DNS resolution are enabled for ECS tasks to resolve EFS mount points correctly.

⚠️ **EFS Encryption**: This deployment uses encryption in transit on port 2999 for EFS connections.

⚠️ **Cost**: Remember to destroy resources when not in use to avoid unnecessary AWS charges.

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

## Troubleshooting

### ECS Task Cannot Mount EFS

**Issue**: ECS task fails to resolve EFS DNS name

**Solution**: Enable DNS hostnames and DNS resolution in the VPC settings:
```hcl
resource "aws_vpc" "main" {
  enable_dns_hostnames = true
  enable_dns_support   = true
}
```

### Container Health Checks Failing

**Issue**: Tasks are being marked as unhealthy

**Solution**: Verify security group rules allow ALB to communicate with ECS tasks on port 80

## Project Structure

```
.
├── Dockerfile              # Custom Nginx container definition
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Terraform variables
├── outputs.tf              # Terraform outputs
└── README.md              # This file
```

## Author

**Zaeem Attique Ashar**  
Cloud Intern

## License

This project is available for educational and demonstration purposes.

---

**Note**: Replace placeholder values like `<repository-url>`, `<account-id>`, and `<your-repo-name>` with your actual values before deployment.
