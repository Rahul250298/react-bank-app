# Use an official Node.js with Nginx image as the base image
FROM node:14.18.3-buster-slim

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the React application
RUN npm run build

# Configure Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*  && \
    rm -rf /var/www/html/*
    
RUN cp -r /app/dist/*    /var/www/html/    
# Expose port 80 for incoming HTTP traffic
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
