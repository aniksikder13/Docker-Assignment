ARG NODE_VERSION=24.12.0

# Declare the base image
FROM node:${NODE_VERSION}-alpine AS base

# Staege 1: Build the application
FROM base AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./

RUN --mount=type=cache,target=/root/.npm,sharing=locked \
     npm ci && npm cache clean --force

# Copy the rest of the application code
COPY . .
# Build the application
RUN npm run build

# Stage 2: Create the production image
FROM base AS production
WORKDIR /app

COPY package*.json ./
RUN --mount=type=cache,target=/root/.npm,sharing=locked \
     npm ci --omit=dev && npm cache clean --force

# Copy only the necessary files for production
COPY --from=builder /app/dist ./

# Add a non-root user to run the application
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup  && \
    chown -R appuser:appgroup /app

USER appuser

# Start the application
CMD ["node", "server.js"]