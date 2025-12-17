ARG NODE_VERSION=24.12.0

# Declare the base image
FROM node:${NODE_VERSION}-alpine AS base

# Staege 1: Build the application
FROM base AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./

RUN npm ci

# Copy the rest of the application code
COPY . .
# Build the application
RUN npm run build

# Stage 2: Create the production image
FROM base AS production
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

# Copy only the necessary files for production
COPY --from=builder /app/dist ./dist

# Add a non-root user to run the application
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup  && \
    chown -R appuser:appgroup /app

USER appuser

EXPOSE 3000 5173 9229

# Start the application
CMD ["node", "dist/server.js"]