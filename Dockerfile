# ---------- Stage 1: Build dependencies ----------
FROM node:24-alpine AS build

WORKDIR /app

# Copy only package files first
COPY package*.json ./

# Install dependencies
RUN npm install
RUN npm install mysql2

# Copy the rest of the source code
COPY . .

# ---------- Stage 2: Runtime image ----------
FROM node:24-alpine

WORKDIR /app

# Copy only the built app + node_modules from the build stage
COPY --from=build /app /app

EXPOSE 3000

CMD ["node", "src/index.js"]
