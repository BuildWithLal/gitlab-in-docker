### GitLab Setup Using Docker Compose: A Beginner’s Guide


We'll be creating exactly those same things we did in prev video to setup gitlab server in docker container
BUT this time instead of running and managing everything using docker commands and passing flags using command line, we'll be handling it using docker compose. Which makes it easy to because it has yaml file where you can
instruct docker compose what to do including docker image, ports, container name, volumes etc

GitLab official docker image on docker hub
https://hub.docker.com/r/gitlab/gitlab-ce

```
docker compose up
```

Wait a couple of mins and then visit
http://localhost:8088

Login and create a test repo

##### Stop GitLab container
```
CTRL + C
```

OR

in a separate terminal
```
docker compose stop
```

##### Start GitLab container
```
docker compose up
```

Repo is there as it was before

##### What if i remove GitLab container at all
```
docker compose stop
```
```
docker ps -a
```
Container should be there as stopped

```
docker compose down
```
```
docker ps -a
```
No container anymore...

And create GitLab container again
```
docker compose up
```

###### What! repos are lost? 
because we deleted container and everythig within that container is lost
So how to retain GitLab data?
First, lets see where GitLab keep its data and configs
```
docker exec -it {CONTAINER_ID} ls -l /etc/gitlab
```
This ^ keep password, secrets and other configurations

```
docker exec -it {CONTAINER_ID} ls -l /var/opt/gitlab
```

This keep actual GitLab data including redis and postgres

So we need to make these 2 dirs persistent from container into our host machine using
docker volumes


##### Using volumes
```
docker compose up
```
`./gitlab/config` is a dir on my host machine inside my current folder
`/etc/gitlab` is a dir inside container

Check `./gitlab` dir in current folder for both configs and data

delete GitLab container and re-create. Everything should be there as it was
```
docker compose stop
```
```
docker compose down
```
```
docker compose up
```

That was all about GitLab server in a container using docker compose.
In the next part, i'll show you how to setup GitLab runner, connect it with GitLab server
and register an executor to run CI/CDs jobs and pipelines
[See here](../3.%20setup-gitlab-runner-with-docker-executor/runner-instance.md)
