##### Register GitLab runner executor with GitLab Server

##### If you love to watch a video, you can find all these stuff in a video here
<br/>

[![Register GitLab runner instance with Docker Executor](https://img.youtube.com/vi/Rvh7OZbDJ_o/0.jpg)](https://www.youtube.com/watch?v=Rvh7OZbDJ_o)

run pipeline, nothing happens as we don't have a gitlab runner.

close pipeline/build page

create a runner instance. and show register command we need to run in gitlab-runner

Add gitlab-runner service to compose and rebuild

login to runner container

```
docker exec it {CONTAINER_ID} /bin/bash
```

Copy command

```
gitlab-runner register --token glrt-rndvpmATt-ydeeTgsaxT --docker-network-mode host
```

see diagram - executor.png

using docker host network because our jobs will be running inside a docker executor (docker container)
which is nested container inside our gitlab-runner container
so nested container doens't know about the parent container using localhost or container name
we need to put executor container on hour host network as well so they will be on the same network
and hence can access its parent's sibling containers like gitlab-server


Enter GitLab instance URL
http://gitlab-server:8088

to communicate from container to container you need to use container name. if you want to connect through localhost i.e localhost:8088, you need to put gitlab-runner container on host network using docker compose. see `network_mode: host` in docker compose

see both executor.png and runner.png

So there are 2 cases where you need to put containers on host network.
One is put your gitlab-runner on host network. this is optional and needed only if you want to connect to gilab-server using localhost instead of container name
and is used when we are registering our executor using gitlab-runner command.

The other one is when our job executor is cloning our repositoy inside our executor container. Executor needs to communicate with gitlab-server to clone repository


Exectutor
docker

Image
python:alpine

all steps completed.

check runners in admin area
check runners in project runners as shared runner

run pipeline


this was totally a manual setup to first create a runner instance, then copy and paste that command
and run inside gitlab-runner to register our executor

We can also automate this process. So the moment we start our container, we'll register our executor. and we can start running our pipelines and jobs

in the next part, i'll show you how to auto register a job executor in a gitlab runner
[See here](../4.%20auto-register-gitlab-runner-with-docker-executor)
