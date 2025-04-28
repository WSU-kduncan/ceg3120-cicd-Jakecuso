# Project Overview - CEG3120 Project 4 And 5

This repository implements a full Continuous Integration (CI) and Continuous Deployment (CD) pipeline for an Angular application using Docker, GitHub Actions, DockerHub, and AWS EC2.

## Repository Structure

- `project4/`  
  - Previous project work and resources used during the initial CI setup (Dockerfile, Angular app).
- `project5/`  
  - Current Angular application source code.
  - Dockerfile for building the application container.
  - Deployment folder containing:
    - `refresh_container.sh` - Bash script to refresh the container on the EC2 instance.
    - `hooks.json` - Webhook definition to automate container updates.
    - `webhook.service` - Systemd service to run webhook on EC2 boot.
- `.github/workflows/`  
  - GitHub Actions workflow file automating container image builds and pushes to DockerHub.
- `images/`  
  - Screenshots documenting setup, testing, and validation processes.

---

## Documentation Links

- [README-CI.md](https://github.com/WSU-kduncan/ceg3120-cicd-Jakecuso/blob/main/project4/README.MD)
  - **Continuous Integration (CI) Documentation**  
  - Explains how the project uses GitHub Actions to automate Docker image builds, semantic versioning with git tags, and pushing container images to DockerHub.

- [README-CD.md](https://github.com/WSU-kduncan/ceg3120-cicd-Jakecuso/blob/main/project5/README.md)
  - **Continuous Deployment (CD) Documentation**  
  - Describes the deployment setup on AWS EC2, including webhook configuration, bash scripting for container updates, and automation of live server refreshes when new images are pushed.

---

## Summary

This project demonstrates how code changes made by a developer can automatically trigger container rebuilds, DockerHub updates, webhook payloads, and container refreshes on a production server — achieving a fully automated DevOps workflow for an Angular application.

## **Resources**
###### For additional information, guides, and references related to Docker, GitHub Actions, Angular, and more, check out the [Resources](https://github.com/WSU-kduncan/ceg3120-cicd-Jakecuso/blob/main/project4/README-RESOURCES.md). That I used to make this Project :)
