Terraform Docker Project - Infrastructure as Code (IaC)
Project Objective
Provision a local Docker container using Terraform with Infrastructure as Code (IaC) principles.

Steps Completed
1. Prerequisites Setup
✅ Verified Docker installation and daemon running

✅ Installed Terraform on Windows

✅ Added Terraform to system PATH

2. Project Initialization
✅ Created project directory: C:\terraform-docker-project

✅ Ran terraform init to download Docker provider

3. Infrastructure Planning
✅ Created main.tf with Terraform configuration

✅ Ran terraform plan to review infrastructure changes

✅ Verified resource creation plan (2 resources)

4. Infrastructure Deployment
✅ Ran terraform apply to create resources

✅ Successfully created Docker image (nginx:latest)

✅ Successfully created Docker container (my-nginx-container)

5. Resource Verification
✅ Verified container with docker ps

✅ Container running on port 8080

✅ Nginx accessible at http://localhost:8080

6. State Management
✅ Listed managed resources with terraform state list

✅ Inspected container details with terraform state show

✅ Verified Terraform state file (terraform.tfstate)

Key Files
main.tf - Terraform configuration for Docker container provisioning

terraform.tfstate - Infrastructure state (auto-generated)

EXECUTION_LOGS.md - Detailed execution logs and documentation

README.md - This file

Resources Created
Docker Image: nginx:latest

Docker Container: my-nginx-container

Port Mapping: 0.0.0.0:8080 -> 80/tcp

Restart Policy: Always

Terraform Commands Used
bash
terraform init      # Initialize provider
terraform plan      # Preview changes
terraform apply     # Create resources
terraform state list    # List resources
terraform state show    # Show resource details
terraform destroy   # Cleanup resources (optional)
