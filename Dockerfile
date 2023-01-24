FROM jenkins/jenkins:lts
USER root
ENV PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LANG=C.UTF-8
ENV JENKINS_HOME=/var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT=50000
ENV REF=/usr/share/jenkins/ref
ENV JENKINS_UC=https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
ENV JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals
ENV COPY_REFERENCE_FILE_LOG=/var/jenkins_home/copy_reference_file.log
ENV JAVA_HOME=/opt/java/openjdk

RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && apt update && apt install python3.9 \
apt-transport-https \
ca-certificates \
curl \
gnupg2 \
software-properties-common -y && \
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg > /tmp/dkey; apt-key add /tmp/dkey && \
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable" && \
   apt update && \
apt-get -y install docker-ce docker-compose python3-pip  && pip3 install ansible-lint molecule-docker molecule ansible      

ENTRYPOINT [ "/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]

