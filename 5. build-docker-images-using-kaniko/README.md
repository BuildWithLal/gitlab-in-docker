#### Job executor using /var/run/docker.sock from host docker engine
![image](https://github.com/user-attachments/assets/fa5ef2e3-e5ec-4f32-b90f-49f029c18aa3)

<br/>

#### Job executor using Docker-in-Dockerservice
![image](https://github.com/user-attachments/assets/ccb7f92b-09a3-4e4f-9f6d-47eda0f15521)


<br/>

#### Register Kaniko Runner
```
gitlab-runner register \
              --url http://localhost:8000  \
              --token glrt-Y9BCAyZZyFhrrkezJbC8 \
              --executor docker \
              --docker-image "gcr.io/kaniko-project/executor:v1.23.2-debug" \
              --docker-network-mode "host"
```
