### Dockerized GitLab: How to Easily Set Up Your Own GitLab Server

<br/>

Read on Medium.com [Dockerized GitLab: How to Easily Set Up Your Own GitLab Server](https://medium.com/@BuildWithLal/dockerized-gitlab-how-to-easily-set-up-your-own-gitlab-server-9a925be09c59)


##### Watch it on YouTube

[![GitLab Server in Docker Container](https://img.youtube.com/vi/FaHdMUAQgck/0.jpg)](https://www.youtube.com/watch?v=FaHdMUAQgck)

GitLab official docker image on docker hub
https://hub.docker.com/r/gitlab/gitlab-ce

```
docker run -p 8000:80 gitlab/gitlab-ce
```

Wait a couple of mins and then visit
http://localhost:8000

default user is `root`

##### Get root password?
```
docker ps --latest # copy GitLab container id from here
docker exec -it {CONTAINER_ID} cat /etc/gitlab/initial_root_password
```

Login and create a test repo

##### Stop GitLab container
```
docker stop {CONTAINER_ID}
```

##### Start GitLab container
```
docker start --attach {CONTAINER_ID}
```

Repo is there as it was before

##### What if i remove GitLab container at all
```
docker stop {CONTAINER_ID}
docker rm {CONTAINER_ID}
```

And create GitLab container again
```
docker run --port 8000:80 gitlab/gitlab-ce
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

Keep old password: 16Gf2RkJBRnIKJe4kHH++klHtR53X7f1WOpI5/FCrYQ=
to be compared wih new password

##### Using volumes
```
docker run -p 8000:80 -v ./gitlab/config:/etc/gitlab -v ./gitlab/data:/var/opt/gitlab gitlab/gitlab-ce
```
`./gitlab/config` is a dir on my host machine inside my current folder
`/etc/gitlab` is a dir inside container

Check `./gitlab` dir in current folder for both configs and data

delete GitLab container and re-create. Everything should be there as it was
```
docker stop {CONTAINER_ID}
docker rm {CONTAINER_ID}
docker run -p 8000:80 -v ./gitlab/config:/etc/gitlab -v ./gitlab/data:/var/opt/gitlab gitlab/gitlab-ce
```

All these commands seems like too much manual commands running. How we can combine all these
into a single file and a single command?
Here comes docker compose. [See here](../2.%20gitlab-in-docker-compose)
