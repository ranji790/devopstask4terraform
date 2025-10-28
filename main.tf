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
