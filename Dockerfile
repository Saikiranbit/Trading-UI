FROM node:18

# Set working directory
WORKDIR /app

# Copy only package.json and lock file first (to cache layer)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install -g pm2 && npm install --legacy-peer-deps

# Copy app code
COPY . .

# Expose port (optional, e.g., for local run)
EXPOSE 3000

# Default command to run your app (can be changed as needed)
CMD ["pm2-runtime", "npm", "--", "start"]
