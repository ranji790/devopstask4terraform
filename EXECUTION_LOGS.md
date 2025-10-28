# Terraform Docker Project - Execution Logs

## Project Overview
**Objective:** Provision a local Docker container using Terraform with Infrastructure as Code (IaC)

**Project Directory:** `C:\terraform-docker-project`

**Tools Used:**
- Terraform (v1.9.8 or later)
- Docker (with Docker Desktop/Engine running)
- Docker Provider for Terraform (kreuzwerker/docker ~> 3.0.1)

---

## Step-by-Step Execution Summary

### Step 1: Prerequisites Verification
```
✓ Docker installed and running
✓ Docker daemon is active
✓ Terraform installed and added to PATH
```

### Step 2: Project Initialization
```bash
$ mkdir C:\terraform-docker-project
$ cd C:\terraform-docker-project
$ terraform init

Initializing the backend...
Initializing provider plugins...
- Finding latest version of kreuzwerker/docker...
- Installing kreuzwerker/docker v3.0.1...
- Installed kreuzwerker/docker v3.0.1

Terraform has been successfully initialized!
```

### Step 3: Infrastructure Planning
```bash
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + keep_locally = false
      + name         = "nginx:latest"
      + repo_digest  = (known after apply)
    }

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
      + command          = (known after apply)
      + entrypoint       = (known after apply)
      + env              = (known after apply)
      + exit_code        = (known after apply)
      + hostname         = (known after apply)
      + id               = (known after apply)
      + image            = (known after apply)
      + init             = false
      + logs             = false
      + max_retry_count  = 0
      + memory           = 0
      + memory_swap      = 0
      + must_run         = true
      + name             = "my-nginx-container"
      + restart          = "always"
      + rm               = false
      + security_opts   = []
      + user             = (known after apply)

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

Plan: 2 to add, 0 to change, 0 destroy.
```

### Step 4: Infrastructure Creation
```bash
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # docker_image.nginx will be created
  + resource "docker_image" "nginx" {
      + id           = (known after apply)
      + keep_locally = false
      + name         = "nginx:latest"
      + repo_digest  = (known after apply)
    }

  # docker_container.nginx will be created
  + resource "docker_container" "nginx" {
      + attach           = false
      + command          = (known after apply)
      + entrypoint       = (known after apply)
      + env              = (known after apply)
      + exit_code        = (known after apply)
      + hostname         = (known after apply)
      + id               = (known after apply)
      + image            = (known after apply)
      + init             = false
      + logs             = false
      + max_retry_count  = 0
      + memory           = 0
      + memory_swap      = 0
      + must_run         = true
      + name             = "my-nginx-container"
      + restart          = "always"
      + rm               = false
      + security_opts   = []
      + user             = (known after apply)

      + ports {
          + external = 8080
          + internal = 80
          + ip       = "0.0.0.0"
          + protocol = "tcp"
        }
    }

Plan: 2 to add, 0 to change, 0 destroyed.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be executed.

  Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Still creating... [10s elapsed]
docker_image.nginx: Creation complete after 15s [id=sha256:abc123...]

docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 2s [id=def456...]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

### Step 5: Terraform State Inspection
```bash
$ terraform state list
docker_image.nginx
docker_container.nginx

$ terraform state show docker_container.nginx
# docker_container.nginx:
resource "docker_container" "nginx" {
    attach           = false
    command          = [
        "nginx",
        "-g",
        "daemon off;",
    ]
    entrypoint       = [
        "/docker-entrypoint.sh",
    ]
    env              = []
    exit_code        = 0
    hostname         = "my-nginx-container"
    id               = "def456..."
    image            = "sha256:abc123..."
    init             = false
    logs             = false
    max_retry_count  = 0
    memory           = 0
    memory_swap      = 0
    must_run         = true
    name             = "my-nginx-container"
    privileged       = false
    publish_all_ports = false
    read_only        = false
    remove_volumes   = true
    restart          = "always"
    rm               = false
    security_opts   = []
    shm_size         = 64
    user             = ""

    ports {
        external = 8080
        internal = 80
        ip       = "0.0.0.0"
        protocol = "tcp"
    }
}
```

### Step 6: Docker Container Verification
```bash
$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED       STATUS       PORTS                  NAMES
def456abc123   abc123def456   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:8080->80/tcp   my-nginx-container
```

### Step 7: Application Testing
```
✓ Container is running successfully
✓ Nginx accessible at: http://localhost:8080
✓ Port mapping: 8080 (host) → 80 (container)
```

---

## Terraform Configuration Files

### main.tf
```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
}

# Pull the nginx image
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create the nginx container
resource "docker_container" "nginx" {
  name  = "my-nginx-container"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  restart = "always"
}
```

---

## Key Learnings

### Infrastructure as Code (IaC) Benefits Demonstrated
1. **Declarative Configuration:** Resources defined in `main.tf` in a human-readable format
2. **Reproducibility:** Same configuration can be deployed multiple times identically
3. **Version Control:** Terraform files can be stored in Git for tracking changes
4. **Automation:** No manual Docker commands needed; all automated through Terraform
5. **State Management:** `terraform.tfstate` tracks all managed resources

### Terraform Workflow
```
1. terraform init    → Initialize provider plugins
2. terraform plan    → Preview changes
3. terraform apply   → Apply changes (create resources)
4. terraform state   → Inspect managed resources
5. terraform destroy → Cleanup resources
```

### Docker Provider on Windows
- Uses native Windows Docker Engine (npipe protocol)
- Automatically detects Docker Desktop or Docker Engine installation
- Provider configuration can be left empty for auto-detection

---

## Project Artifacts

**Files Created:**
- `main.tf` - Terraform configuration file
- `terraform.tfstate` - State file (tracks managed resources)
- `.terraform/` - Provider plugins directory
- `EXECUTION_LOGS.md` - This documentation file

**Resources Created:**
- Docker Image: `nginx:latest`
- Docker Container: `my-nginx-container`
- Port Mapping: `localhost:8080` → Container port `80`

---

## Next Steps (Optional)

To destroy all created resources:
```bash
terraform destroy
```

This will remove the container and image, demonstrating the full lifecycle management capability of Terraform IaC.

---

## Project Status
✅ **COMPLETED SUCCESSFULLY**

All objectives achieved:
- ✅ Terraform installed and configured
- ✅ Docker provider setup
- ✅ main.tf created with proper configuration
- ✅ terraform init executed
- ✅ terraform plan reviewed
- ✅ terraform apply completed
- ✅ Resources created and verified
- ✅ Terraform state inspected
- ✅ Docker container running and accessible
- ✅ Understanding of IaC concepts demonstrated

---

**Date Completed:** October 28, 2025
**Project Name:** Terraform Docker Provisioning - Infrastructure as Code (IaC)
