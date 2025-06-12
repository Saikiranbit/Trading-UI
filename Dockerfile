FROM node:18

# Set app directory
WORKDIR /app

# Copy package.json and install deps
COPY package.json package-lock.json ./
RUN npm install -g pm2 && npm install

# Copy the rest of the code
COPY . .

# Build React app
RUN npm run build

# Expose port
EXPOSE 3000

# Start app with PM2
CMD ["pm2-runtime", "npm", "--name", "Trading-UI", "--", "start"]
