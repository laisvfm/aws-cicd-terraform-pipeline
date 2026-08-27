#!/bin/bash

# Update system packages (dnf is correct for Amazon Linux, not apt-get)
dnf update -y

# Install Docker directly from the official Amazon Linux repository
dnf install -y docker

# Enable and start the Docker service
systemctl enable docker
systemctl start docker

# Add the correct user to the docker group (ec2-user, not "ubuntu")
usermod -aG docker ec2-user