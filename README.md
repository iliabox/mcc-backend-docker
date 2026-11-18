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

The workflow `.github/workflows/docker.yml` builds the image for `linux/amd64` and `linux/arm64` and pushes to Docker Hub:

* on every published release (**Releases → Draft a new release**, tag like `v8.5.13`): `crudml/mcc-backend:latest` and `crudml/mcc-backend:8.5.13` — the version tag is taken from the release tag (leading `v` is stripped)
* manual run via **Actions → docker → Run workflow** pushes only `crudml/mcc-backend:latest`

Pushes to `master` do not trigger a build.

Required repository secrets (**Settings → Secrets and variables → Actions → New repository secret**):

* `DOCKERHUB_USERNAME` — your Docker Hub username (`crudml`)
* `DOCKERHUB_TOKEN` — Docker Hub access token (**Account Settings → Security → New Access Token**), not your password

