# S13 Training Camps

A self-contained student training website that runs as one Docker container.

## Single-container architecture

The `app` container provides everything:

- Responsive HTML, CSS, and JavaScript website
- Course catalog API
- Student registration and login API
- Enrollment API
- File-based demo persistence through the `app-data` Docker volume

The application uses only the Node.js standard library and has no package dependencies. CI publishes images tagged with the full Git commit SHA.

## Tools used

- HTML5, CSS3, and vanilla JavaScript
- Node.js 22
- Docker and Docker Compose
- Forgejo Actions
- Git and curl

## Run

```bash
docker build -t s13-training-camps:latest .
docker volume create s13-training-camps-data
docker run -d --name s13-training-camps --restart unless-stopped -p 8080:8080 -v s13-training-camps-data:/data s13-training-camps:latest
```

Open <http://localhost:8080>.

## Verify

```bash
docker ps --filter name=s13-training-camps
curl http://localhost:8080/health
curl http://localhost:8080/api/courses
```

## Stop

```bash
docker rm -f s13-training-camps
```

Use `docker volume rm s13-training-camps-data` only when you intentionally want to delete saved demo users and enrollments.

## CI/CD

`.github/workflows/docker-build.yml` builds the image from the root `Dockerfile` on a GitHub-hosted `ubuntu-latest` runner for every push and pull request. Pushes publish `devopseasylearning/s13-training-camps:<full-commit-sha>` to Docker Hub; pull requests build without publishing. The workflow uses the GitHub Environment named `DOCKEHUB_TOKEN`, with a `DOCKERHUB_TOKEN` Actions secret containing a Docker Hub access token.

Pull an image with:

```bash
docker pull devopseasylearning/s13-training-camps:<commit-sha>
```
