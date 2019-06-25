FROM openjdk:8-jdk-stretch

# Install components that are required for Docker
RUN apt-get update && \ 
    apt-get install -y \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg-agent \
            software-properties-common

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) \
       stable"

RUN apt-get update && \
    apt-get install -y git python \
                       docker-ce

RUN mkdir -p /usr/share/jenkins && \
    wget -O /usr/share/jenkins/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.13/swarm-client-3.13.jar && \
    chmod -R 755 /usr/share/jenkins

VOLUME /var/run/docker.sock

USER root

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
