#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update and upgrade system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Java (Jenkins requires Java 17)
echo "Installing OpenJDK 17..."
sudo apt install -y openjdk-17-jdk

# Verify Java installation
java -version

# Add Jenkins repository key
echo "Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo "Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists
echo "Updating package lists..."
sudo apt update

# Install Jenkins
echo "Installing Jenkins..."
sudo apt install -y jenkins

# Start and enable Jenkins service
echo "Starting Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Check Jenkins status
echo "Checking Jenkins service status..."
sudo systemctl status jenkins --no-pager

# Get Raspberry Pi's IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')
echo "Jenkins is installed and running on: http://$IP_ADDRESS:8080"

# Display initial Jenkins admin password
echo "Fetching initial admin password..."
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
