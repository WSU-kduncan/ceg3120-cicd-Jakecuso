#!/bin/bash

CONTAINER_NAME="angular_app"
IMAGE_NAME="jakecuso/mancuso-ceg3120:latest"

echo "Stopping existing container (if running)..."
sudo docker stop $CONTAINER_NAME

echo "Removing existing container (if exists)..."
sudo docker rm $CONTAINER_NAME

echo "Pulling latest image from DockerHub..."
sudo docker pull $IMAGE_NAME

echo "Running new container..."
sudo docker run -dit --name $CONTAINER_NAME -p 4200:4200 $IMAGE_NAME

echo "Deployment refresh complete."
