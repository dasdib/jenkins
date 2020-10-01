FROM jenkins/jenkins:lts
USER root

RUN apt-get update && apt-get install -y git curl openjdk-8-jdk && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/download && \
 curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz | tar -xz -C /tmp/download && \
 rm -rf /tmp/download/docker/dockerd && \
 mv /tmp/download/docker/docker* /usr/local/bin/ && \
 rm -rf /tmp/download && \
 groupadd -g 999 docker && \
 usermod -aG staff,docker jenkins

 USER jenkins