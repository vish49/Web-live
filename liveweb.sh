#!/bin/bash

# Install Docker
echo "Installing Docker..."
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Install Kubernetes with Minikube
echo "Installing Minikube and kubectl..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
sudo install kubectl /usr/local/bin/kubectl

# Start Minikube cluster
echo "Starting Minikube cluster..."
minikube start --vm-driver=docker

# Deploy a sample web application
echo "Deploying sample web application..."
git@github.com:vish49/Web-live.git
kubectl apply -f ingress-controller.yaml
kubectl apply -f magicalnginx-deployment-service.yaml
kubectl apply -f magicalnginx-nginx-deployment.yaml

# Wait for deployment to be ready
echo "Waiting for deployment to be ready..."
kubectl get pods
kubectl get ing

# Get the external IP address

echo "Web application deployed successfully!"
