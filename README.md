### Docker Commands Used

| Command | Purpose |
|---------|---------|
| `docker compose up --build -d` | Build images and start all services in detached mode |
| `docker compose down` | Stop and remove containers, networks |
| `docker compose ps` | List running containers and status |
| `docker compose logs todoapp` | View logs for Node.js app |
| `docker compose logs db` | View logs for PostgreSQL |
| `docker compose exec todoapp sh` | Open shell in Node.js container |
| `docker compose exec db psql -U $POSTGRES_USER` | Connect to PostgreSQL CLI |
| `docker image ls` | List all images and sizes |
| `docker history <image_name>:<tag>` | Show layers of an image |
| `docker push <image_name>:<tag>` | Push image to Docker Hub |

### Docker Image Size Review

Image: `anik313/docker-assignment-node-app:v1`  
**Size:** 263MB  

### Docker Image Layers Analysis

| Layer # | Command | Size |
|---------|---------|------|
| 1  | ADD alpine-minirootfs-3.23.0-x86_64.tar.gz / | 3.68 MB |
| 2  | CMD ["/bin/sh"] | 0 B |
| 3  | ENV NODE_VERSION=24.12.0 | 0 B |
| 4  | RUN addgroup -g ... | 48.61 MB |
| 5  | ENV YARN_VERSION=1.22.22 | 0 B |
| 6  | RUN apk add ... | 1.2 MB |
| 7  | COPY docker-entrypoint.sh /usr/local/bin/ | 445 B |
| 8  | ENTRYPOINT ["docker-entrypoint.sh"] | 0 B |
| 9  | CMD ["node"] | 0 B |
| 10 | WORKDIR /app | 93 B |
| 11 | COPY package*.json ./ | 143.53 KB |
| 12 | RUN npm ci | 2.28 MB |
| 13 | COPY /app/dist ./ | 76.1 KB |
| 14 | RUN addgroup -S ... | 1.96 MB |
| 15 | USER appuser | 0 B |
| 16 | CMD ["node", "server.js"] | 0 B |

**Total layers:** 16  
