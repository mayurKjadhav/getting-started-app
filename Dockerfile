# Use Node 24 Alpine
FROM node:24-alpine

# Create app directory
WORKDIR /app

# Copy package files first (better layer caching)
COPY package*.json ./

# Install only production dependencies
RUN npm ci --omit=dev

# Copy rest of application
COPY . .

# Start the app
CMD ["node", "src/index.js"]

# Expose app port (change if needed)
EXPOSE 3000
