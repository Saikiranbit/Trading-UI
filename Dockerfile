# Use official Node.js LTS base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install -g pm2 && npm install

# Copy the rest of the app
COPY . .

# Build the React app
RUN npm run build

# Serve the build directory with PM2
CMD ["pm2-runtime", "npm", "--", "start"]
