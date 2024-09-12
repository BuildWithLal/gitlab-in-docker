#### Watch it on YouTube
[![register-gitlab-runner-with-docker-executor](https://img.youtube.com/vi/Rvh7OZbDJ_o/0.jpg)](https://www.youtube.com/2koljDo0M70?v=Rvh7OZbDJ_o)


#### Runner Registeration Command for Docker in Docker
```
gitlab-runner register  --url http://localhost:8000 \
                        --token glrt-qL_FTjkAGqy7SHcYYStx \
                        --executor docker \
                        --name "Docker in Docker Runner" \
                        --docker-image "docker:27.2.0" \
                        --docker-privileged \
                        --docker-volumes "/certs/client" \
                        --docker-network-mode "gitlab-in-docker" \
                        --clone-url "http://gitlab-server:8000"
```

#### GitLab Networking
![Screenshot from 2024-09-11 15-08-50](https://github.com/user-attachments/assets/f6353038-44e6-433e-8a77-423f62f02840)

#### How GitLab runner use /var/run/docker.sock for container creation
![image](https://github.com/user-attachments/assets/1566848a-57a7-44e9-8a2d-9e98d7525e5c)

#### How GitLab runner use Docker-in-Docker service for container creation
![image](https://github.com/user-attachments/assets/54cdbd27-ce02-4727-9040-9c3792757b7b)


