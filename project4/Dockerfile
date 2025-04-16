# Use the official Node.js image as base
FROM node:18-bullseye

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the angular-bird directory into the container
COPY angular-site/angular-bird /usr/src/app

# Install Angular CLI and dependencies
RUN npm install -g @angular/cli
RUN npm install

# Expose port 4200 (default Angular port)
EXPOSE 4200

# Command to start the Angular app
CMD ["ng", "serve", "--host", "0.0.0.0"]
