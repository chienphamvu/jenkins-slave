FROM openjdk:8-jre-stretch

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    apt-key fingerprint 0EBFCD88 && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"

RUN apt-get update && \
    apt-get install -y git python \
                       docker-ce docker-ce-cli containerd.io

RUN mkdir -p /usr/share/jenkins && \
    wget -O /usr/share/jenkins/swarm-client.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.13/swarm-client-3.13.jar && \
    chmod -R 755 /usr/share/jenkins

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
