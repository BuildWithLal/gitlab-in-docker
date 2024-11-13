##### Scan Docker images for security issues in external libraries. Uses Trivy to identify vulnerabilities in dependencies.
___

![image](https://github.com/user-attachments/assets/89909746-8d1d-4761-a914-efdb6f59fce7)


GitLab shows vulnerabilities in merge requests and saves a downloadable report.

#### Requirements
   - Add a `test` stage in `.gitlab-ci.yml`.
   - Use a GitLab Runner with Docker or Kubernetes.
   - Push the Docker image to the project’s container registry.
   - If using a third-party registry, set `CS_REGISTRY_USER` and `CS_REGISTRY_PASSWORD`.

#### Enable the Scanner
   - Add this to `.gitlab-ci.yml`:
     ```yaml
     include:
       - template: Jobs/Container-Scanning.gitlab-ci.yml
     ```

#### Set up Image Build & Push
   - Define a `build` stage to build and push your Docker image:
     ```yaml
     build:
       stage: build
       image: docker:latest
       script:
         - echo "$CI_REGISTRY_PASSWORD" | docker login $CI_REGISTRY -u $CI_REGISTRY_USER --password-stdin
         - docker build -t "$CI_REGISTRY_IMAGE:${CI_COMMIT_SHA:0:8}" .
         - docker push "$CI_REGISTRY_IMAGE:${CI_COMMIT_SHA:0:8}"
     ```

#### Specify Scanned Image
   - Update the `container_scanning` job to target the built image:
     ```yaml
     container_scanning:
       before_script:
         - export CS_IMAGE="$CI_REGISTRY_IMAGE:${CI_COMMIT_SHA:0:8}"
     ```

#### Customization

- **Severity Threshold**:
   - Set minimum severity level to report (e.g., `medium` or `high`):
     ```yaml
     container_scanning:
       variables:
         CS_SEVERITY_THRESHOLD: 'medium'
     ```

- **Fail Pipeline on High Severity**:
   - Use `jq` to parse results and fail the job if high-severity issues are found:
     ```yaml
     container_scanning:
       allow_failure: false
       before_script:
         - sudo apt-get update -y && sudo apt-get install -y jq
         - export CS_IMAGE="$CI_REGISTRY_IMAGE:${CI_COMMIT_SHA:0:8}"
       script:
         - gtcs scan
         - HIGH_SEVERITY_COUNT=$(jq '.vulnerabilities | map(select(.severity=="High")) | length' gl-container-scanning-report.json)
         - if [[ $HIGH_SEVERITY_COUNT -gt 0 ]]; then exit 1; fi
     ```
