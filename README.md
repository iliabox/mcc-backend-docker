# MCC Backend Docker
 
* alpine
* php-fpm 8.5 (apcu, pdo_mysql, opcache, pcntl, intl)
* composer
* nginx
* supervisord
* curl

## Installation:
_docker pull crudml/mcc-backend:latest_

## Auto build and push (GitHub Actions)

On every push to `master` (or manual run via **Actions → docker → Run workflow**) the workflow `.github/workflows/docker.yml` builds the image for `linux/amd64` and `linux/arm64` and pushes:

* `crudml/mcc-backend:latest`
* `crudml/mcc-backend:8.5.12`

Required repository secrets (**Settings → Secrets and variables → Actions → New repository secret**):

* `DOCKERHUB_USERNAME` — your Docker Hub username (`crudml`)
* `DOCKERHUB_TOKEN` — Docker Hub access token (**Account Settings → Security → New Access Token**), not your password

