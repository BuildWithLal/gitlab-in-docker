----------
Existing
----------

Add gitlab service without health check and runner token to compose
Start GitLab server.
Show runners. There shouldn't be any

-----------
New
-----------
Add GitLab runner service in docker compose

Add runner shared token as env var to gitlab server service in docker compose.
this shared token will be used when registering gitlab runner from gitlab runner container


adding entrypoint so /bin/sh works

```
entrypoint: [""]
```


add runner registeration command and re-run gitlab runner to load new config

```
command: ["/bin/sh", "-c", "gitlab-runner register \
                                    --non-interactive \
                                    --url 'http://localhost:8088' \
                                    --registration-token 'r3g1str4t10n' \ 
                                    --executor 'docker' \
                                    --docker-network-mode 'host' \
                                    --docker-image 'python:alpine' \
        && gitlab-runner run --user=gitlab-runner --working-directory=/etc/gitlab-runner"]
```

Also this command will only work if the gitlab-server is running and accepting requests.
so we need to make runner container dependent server container

we need to add health check to gitlab server
```
healthcheck:
      test: curl --fail http://localhost:8088/users/sign_in || exit 1
      interval: 60s
      timeout: 3s
      retries: 5
```

and add depends_on to runner container so runner will only starts once server container is started and
gitlab server is ready to accept requests
```
depends_on:
    gitlab-server: 
      condition: service_healthy
```
