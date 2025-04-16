# Use the official Node.js image as the base image
FROM node:18-bullseye

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Angular app from your local machine to the container
COPY angular-site/angular-bird /usr/src/app

# Install Angular CLI globally inside the container
RUN npm install -g @angular/cli

# Install the app dependencies based on the package.json
RUN npm install

# Expose port 4200 to access the Angular app
EXPOSE 4200

# Command to run the Angular app
CMD ["ng", "serve", "--host", "0.0.0.0"]

