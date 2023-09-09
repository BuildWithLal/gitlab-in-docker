#### Add GitLab runner instance to GitLab using docker compose

##### If you love to watch a video, you can find all these stuff in a video here
<br/>

[![Register GitLab runner instance](https://img.youtube.com/vi/RFVCWlSmrOk/0.jpg)](https://www.youtube.com/watch?v=RFVCWlSmrOk)

GitLab server official docker image on docker hub
https://hub.docker.com/r/gitlab/gitlab-ce
run with prev compose.yml
```
docker compose up
```

Add a dummy repo with dummy gitlab-ci. run pipeline. job is not executing. stuck

Visit runners under project settings runner from link and admin area. no runners there.

click on New instance runner. Don't register actually. don't click on register. just show messages and walk through job, runner, exectutor

```
this ^ will Create an instance runner to generate a command that registers the runner with all its configurations.
```
and show message. BUT we'll come to this later
```
GitLab Runner must be installed before you can register a runner.
```

GitLab Job: the smallest component of a pipeline, which contains one or more commands that need to be executed (need some executor env).

GitLab Runner: this is an agent installed on a different server (so we need a separate machine) from the GitLab server. The GitLab Runner receives instructions from the GitLab server in regards to which jobs to run. Each runner must be registered with the GitLab server (we can have many runners on same machine or on diff machines).

Runner Executor: each Runner will define at least one executor. An executor is essentially the environment where the job will be executed.
* Shell
* VirtualBox
* Docker
* Kubernetes

now click on register and browser pointing to invalid url0
without nginx port, port mapping to 8088 and external url

set nginx port, change port mapping and add external url

```
docker compose up --build
```

Add new instance runner should be fine now

add runner service

after you create a new instance runner

Register runner
GitLab Runner must be installed before you can register a runner.

Copy and paste the following command into your command line to register the runner.

gitlab-runner register  --url http://localhost:8088  --token glrt-J1n2U-kFyt_V8iVxuPzt

gitlab-runner command is not available in gitlab-server.
these commands need gitlab runner which will be a separate container or a machine with gitlab-runner cli

In the next part, i'll show you how to setup gitlab runner container and and register an executor to run our jobs. [See here](../3.%20setup-gitlab-runner-with-docker-executor/runner-executor.md)
