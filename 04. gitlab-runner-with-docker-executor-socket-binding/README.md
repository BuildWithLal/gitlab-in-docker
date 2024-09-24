
#### Runner Registeration Command for Docker in Docker
```
gitlab-runner register  --url http://localhost:8000 \
                        --token glrt-qL_FTjkAGqy7SHcYYStx \
                        --executor docker \
                        --name "Docker Runner" \
                        --docker-image "python:3.10-alpine" \
                        --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
                        --docker-network-mode "host" \
```

#### GitLab Networking
![Screenshot from 2024-09-11 15-08-50](https://github.com/user-attachments/assets/f6353038-44e6-433e-8a77-423f62f02840)

#### How GitLab runner use /var/run/docker.sock for container creation
![image](https://github.com/user-attachments/assets/1566848a-57a7-44e9-8a2d-9e98d7525e5c)


