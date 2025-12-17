## Simple Node application for practice docker


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
