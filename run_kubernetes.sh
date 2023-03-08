#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=francisngethe/flask-demo:predict

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run flask-demo --image=francisngethe/flask-demo:predict\
    --port=80 

# Step 3:
# List kubernetes pods
kubectl get po -A

# Step 4:
# Forward the container port to a host
kubectl port-forward flask-demo 8000:80

# command to pull docker image
# docker pull francisngethe/flask-demo:predict


