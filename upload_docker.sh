#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

#step 1:
# create a new tag for the docker image 
# default tag for image predict is latest 
# created a public repo on Docker Hub called flask-demo
docker tag predict:latest francisngethe/flask-demo:predict
# Step 2:
# Create dockerpath
dockerpath=francisngethe/flask-demo:predict
# Step 3:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
# Step 4:
# Push image to a docker repository
docker push francisngethe/flask-demo:predict
