#!/bin/bash

# use this file to run the prerequistes that are 
# required within Docker to run the script successfully

# Check if unzip is installed and install it if necessary
# if ! command -v unzip &>/dev/null; then
#     echo "unzip is not installed. Installing unzip..."
#     sudo apt-get update
#     sudo apt-get install -y unzip
# fi

# deleting any file with gradle

# rm -rf /opt/gradle/gradle-8.1.1

# Install Gradle
if ! [ -d /opt/gradle/gradle-8.1.1/bin/ ]; then
wget https://services.gradle.org/distributions/gradle-8.1.1-bin.zip -P /tmp
sudo unzip -d /opt/gradle /tmp/gradle-8.1.1-bin.zip
fi
export PATH="/opt/gradle/gradle-8.1.1/bin:$PATH" >> ~/.bashrc

source ~/.bashrc
echo $PATH
# Add jenkins user to docker group
# sudo usermod -aG docker jenkins

# Install Docker
if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker jenkins
    sudo systemctl start docker
    sudo systemctl enable docker
fi

# Start Docker service
sudo systemctl start docker

# Set appropriate permissions for the Docker daemon socket
sudo chmod 666 /var/run/docker.sock

# Restart Docker service
sudo systemctl restart docker

