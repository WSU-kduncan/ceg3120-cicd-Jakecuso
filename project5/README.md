# Continuous Deployment (CD) Workflow 

This document provides the steps for **generating tags**, **viewing tags**, and **pushing tags** in my Git repository. Tags are essential for versioning and triggering your CI/CD pipelines.

---

## 1) **Generating Tags**

In Git, tags are used to mark specific points in the project’s history. They are commonly used to mark release versions.

To **generate a tag** in Git, use the following command:

```bash
git tag -a <tag_name> -m "<message>"
```
<t-ag_name->: The name of the tag, typically following semantic versioning, e.g., v1.0.0.

<-message->: A short description of the tag (similar to a commit message).

Example:
```bash
git tag -a v1.0.0 -m "First release for Project 5"
```
This will create an annotated tag with the name v1.0.0 and a message "First release for Project 5".

## 2) How to See Tags in a Git Repository?

To see all the tags in your Git repository, I'd use the following command:
```bash
git tag
```
This will list all the tags available in the current repository. For more detailed information about each tag, you can use:
```bash
git show <tag_name>
```
Example:
```bash
git show v1.0.0
```
## 3) How To Generate a Tag in a Git Repository?

To create a new tag in the repository:

Navigate to my repository on my local machine. I 
Ran the following command to create a new tag:
```bash
git tag -a v1.0.1 -m "Tag for version 1.0.1"
```
`Verify the tag was created`:
git tag
This should display `v1.0.1` as part of the list of tags.
## 4) How to Push a Tag in a Git Repository to GitHub

Once you have created a tag locally, you need to push it to GitHub to trigger the CI/CD workflow.

To push a single tag:
```bash
git push origin <tag_name>
```
Example:
```bash
git push origin v1.0.1
```
If I want to push all tags at once:
```
git push --tags
```
This will push all tags that are available in my local repository to GitHub.

---


# Semantic Versioning Container Images with GitHub Actions

This document will explain how the **GitHub Actions workflow** for **semantic versioning** of container images works. The workflow is responsible for automating the process of building, tagging, and pushing Docker images to **DockerHub** when new version tags are pushed to the repository.

---

## Summary of What a Workflow Does and When It Does It

The **workflow** is designed to build and push **Docker images** to **DockerHub** whenever a **version tag** is pushed to the GitHub repository. It uses **semantic versioning** (e.g., `v1.0.0`, `v1.1.0`) to tag the Docker images. The workflow only runs when a tag is pushed to GitHub that follows the pattern `v*.*.*`.

### Trigger:
- The workflow is triggered by **pushes to tags** matching the format `v*.*.*` (e.g., `v1.0.0`, `v2.1.0`).
- The **push** can either come from the `main` branch or from a version tag.

---

## Explanation of Workflow Steps

1. **Checkout the Code**:
   - The workflow checks out the code from the repository using the `actions/checkout@v2` action to ensure the code and Dockerfile are available to the runner.
   ```yaml
   - name: Checkout code
     uses: actions/checkout@v2
    ```
    

2. **Set Up Docker Buildx**:
   - The `docker/setup-buildx-action@v1` action is used to set up **Docker Buildx**, which provides advanced features for building Docker images, including multi-platform support.
   ```yaml
   - name: Set up Docker Buildx
     uses: docker/setup-buildx-action@v1
    ```
3. **Login to DockerHub**:
   - The workflow logs into **DockerHub** using the `docker/login-action@v1` action. It uses the **DockerHub credentials** stored in **GitHub Secrets** (`DOCKER_USERNAME` and `DOCKER_TOKEN`).
   ```yaml
   - name: Login to DockerHub
     uses: docker/login-action@v1
     with:
       username: ${{ secrets.DOCKER_USERNAME }}
       password: ${{ secrets.DOCKER_TOKEN }}
    ```
4. **Build and Push the Docker Image**:
   - The `docker/build-push-action@v2` action is used to build the Docker image from the repository's Dockerfile and push the built image to **DockerHub**. 
   - The image is tagged using **semantic versioning** based on the GitHub tag (e.g., `v1.0.0`, `v1.1.0`).
   ```yaml
   - name: Build and push Docker image
     id: docker_build
     uses: docker/build-push-action@v2
     with:
       context: ./project5  # Build the Docker image from project5 folder
       push: true  # Push the image to DockerHub
       tags: |
         ${{ secrets.DOCKER_USERNAME }}/${{ secrets.DOCKER_HUB_REPO }}:latest
         ${{ secrets.DOCKER_USERNAME }}/${{ secrets.DOCKER_HUB_REPO }}:${{ github.sha }}
         ${{ secrets.DOCKER_USERNAME }}/${{ secrets.DOCKER_HUB_REPO }}:${{ github.ref_name }}
    ```

---

## Explanation / Highlight of Values That Need Updated If Used in a Different Repository

If I was to use this workflow in a **different repository**, the following values need to be updated:

1. **DOCKER_USERNAME**:
   - The DockerHub username must be updated in **GitHub Secrets**. This username will be used for both the login and the tag naming.
   - Example: `your-docker-username`.

2. **DOCKER_HUB_REPO**:
   - The **DockerHub repository** name needs to be updated. This should be the name of the repository in DockerHub where the image will be pushed.
   - Example: `your-repository-name`.

3. **GitHub Secrets**:
   - Update **DOCKER_USERNAME**, **DOCKER_TOKEN**, and **DOCKER_HUB_REPO** in the repository's **GitHub Secrets**.
   - Make sure that the **DockerHub token** has both **read and write** permissions.

4. **Build Context**:
   - If the Dockerfile or the project folder is in a different location, change the `context` value. For example, if I want to build from `project4`, update the context to `./project4`. 
   
   *In my case I have it in both (project 4 & 5 to show my progress) but my most updated workflow is in project 5 so im using that*

---


## Link to Workflow File in my GitHub Repository



[ci-project5.yml Workflow File](https://github.com/WSU-kduncan/ceg3120-cicd-Jakecuso/tree/main/.github/workflows)


---


# Testing & Validating

This section describes how to test and validate that my GitHub Actions workflow for **building and pushing Docker images** works as expected, and how to verify that the image in **DockerHub** works when run in a container.

---

## How I Can Test That My Workflow Did Its Tasking

1. **Verify Workflow Run**:
   - Go to the **GitHub repository** and navigate to the **Actions** tab.
   - Check if the workflow ran successfully when a tag was pushed to the repository.
   - Ensure the workflow completes without errors in the logs. If there are errors, check the logs to identify what went wrong.

2. **Check DockerHub**:
   - Log in to **DockerHub**.
   - Go to the repository where the image was pushed.
   - Verify that the **Docker image** appears in the repository with the appropriate tags (e.g., `latest`, version tag like `v1.0.0`, or commit SHA).

3. **Check Build Logs**:
   - In the **GitHub Actions** tab, review the logs for the **Build and Push Docker image** step. Ensure that the build was successful and that the image was pushed to DockerHub.

---

## How to Verify That the Image in DockerHub Works When a Container Is Run Using the Image (Steps & Instrutions)

Once the Docker image has been pushed to DockerHub, it's important to verify that it works as expected by running a container.

1. **Pull the Image from DockerHub**:
   - On your local machine or in a remote environment, pull the image from DockerHub to ensure it was successfully pushed.
   Example:
   ```bash
     docker pull jakecuso/mancuso-ceg3120:v1.0.0
    ```
2. **Run the Docker Container**:
   - Run the container using the pulled image. You can start a container in interactive mode to test it.
   Example:
   ```bash
     docker run -it jakecuso/mancuso-ceg3120:v1.0.0 bash
    ```
3. **Verify the Container's Functionality**:
   - Once inside the container, check if the application or service that is being containerized is running correctly.
   - You can run commands specific to your application to verify its functionality, such as checking a web service or verifying a running process inside the container.

4. **Check Container Logs**:
   - If the container doesn't behave as expected, view the logs to diagnose the issue.
   Example:
   ```bash
     docker logs <container_id>
    ```
5. **Test the Application**:
   - If your image contains a web application, try to access it through the exposed ports. For example, if the application is supposed to be available on port `80`, you can map the port like this:
   ```bash
     docker run -p 8080:80 jakecuso/mancuso-ceg3120:v1.0.0
    ```
   Then access it through `http://localhost:8080` to verify the application is running as expected.

---

## Part 1 Conclusion

By following these steps, I can **test the workflow** that builds and pushes the Docker image and **validate the functionality** of the image by running it as a container. This ensures that my **CI/CD pipeline** works correctly and that the image I deploy in DockerHub works as intended when run in any environment.

This document explains how my **CI/CD workflow** handles **semantic versioning** for Docker images and automates the process of building and pushing them to DockerHub. The workflow will be triggered by a tag push and will apply the appropriate version tags to my Docker image, ensuring a smooth **continuous deployment** process.

Tags are an essential part of version control in Git and are used extensively in **Continuous Deployment (CD)** workflows. By generating, viewing, and pushing tags, I can trigger automated processes and keep track of versions in my project. 
