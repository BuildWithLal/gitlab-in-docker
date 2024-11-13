#### Enable GitLab Container Registry

**Update `docker-compose.yml`**

Add these lines to enable and expose the registry.

   ```yaml
   gitlab_rails['registry_enabled'] = true
   registry_external_url 'http://localhost:5001'
   ```

**Restart Containers**

Run `docker compose up --build --force-recreate`


#### Setup a New Repository

1. **Login to GitLab**: Create a new repository and access the Container Registry section.
2. **Add a Dockerfile** to the project root for testing purposes.


#### Configure Pipeline for Image Build and Push

1. **Register a GitLab Runner** as a Docker executor (if not done already).
2. **Setup `gitlab-ci.yml` Pipeline**:
   ```yaml
   build:
       stage: build
       image: docker:latest
       tags:
           - docker
       script:
           - echo "$CI_REGISTRY_PASSWORD" | docker login $CI_REGISTRY -u $CI_REGISTRY_USER --password-stdin
           - docker build -t "$CI_REGISTRY_IMAGE:${CI_COMMIT_SHA:0:8}" .
           - docker push "$CI_REGISTRY_IMAGE:${CI_COMMIT_SHA:0:8}"
   ```
   This pipeline logs into the registry, builds the Docker image, tags it, and pushes it to GitLab’s Container Registry.


#### Pull Image from Registry

1. **Copy the Image Path** from the registry and run:
   ```bash
   docker pull localhost:5001/root/build-with-lal:<tag>
   ```
2. **Authenticate if Needed**:
   ```bash
   docker login --username <user> --password <password> localhost:5001
   ```


#### Container Registry Storage Backends

- **File System** (default): `registry_path` can be customized in `gitlab.rb`.
- **Other Options**: Azure, Google Cloud Storage, and S3.


#### Notes

- **Third-Party Registries** are no longer supported as of GitLab 16.0.
- **Registry Authentication**: GitLab manages authentication for secure image access.
