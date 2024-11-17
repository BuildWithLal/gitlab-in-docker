##### Scans your project’s external libraries for security issues, including nested (transitive) dependencies.

___

![image](https://github.com/user-attachments/assets/61818fe4-b81e-4b46-b3b9-b6d9ba5b98cf)


#### Requirements
  - GitLab Ultimate (GitLab.com, Self-managed, or Dedicated).
  - Add a `test` stage in your `.gitlab-ci.yml`.
  - A GitLab Runner with Docker or Kubernetes executor.

#### Steps
  - In `.gitlab-ci.yml`, add this to enable the Dependency Scanning template:
    ```yaml
    include:
      - template: Jobs/Dependency-Scanning.gitlab-ci.yml
    ```
  - Use specific dependency files like `requirements.txt` (up to 2 directories deep) to trigger the scan.

#### Example
  - Add a test dependency (e.g., `requests==2.19.1` in `requirements.txt`) to check for vulnerabilities.
  - Run the pipeline to see scan results in logs and as a downloadable artifact.

#### Fail on High Severity
  - Use `jq` to parse the scan report and stop the pipeline if high-severity issues are found, blocking deployment if any vulnerabilities are detected.
