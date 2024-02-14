FROM jenkins/jenkins:lts as init-jenkins

USER root
# Skip install plugins wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Install init plugins
RUN jenkins-plugin-cli --plugins docker-workflow cloudbees-folder timestamper \
ws-cleanup pipeline-stage-view pam-auth pipeline-github-lib \
matrix-auth ssh build-timeout github-branch-source  ssh-slaves \
email-ext antisamy-markup-formatter workflow-aggregator git ldap authorize-project \
configuration-as-code

RUN jenkins-plugin-cli --plugins kubernetes-cli
RUN jenkins-plugin-cli --plugins ssh-agent


FROM jenkins/jenkins:lts as setup

USER root
ARG COMPOSE_RELEASE=v2.3.3
ARG KUBERNETES_RELEASE=v1.23.3
ARG HELM_RELEASE=v3.8.2
ARG TERRAFORM_RELEASE=1.1.9

# Download kubectl release
RUN curl -L https://dl.k8s.io/release/${KUBERNETES_RELEASE}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl  && \
  chmod +x /usr/local/bin/kubectl
# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_RELEASE}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose
# Install helm 
RUN curl -LO https://get.helm.sh/helm-${HELM_RELEASE}-linux-amd64.tar.gz && tar -zxvf helm-${HELM_RELEASE}-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/ && \
    chmod +x /usr/local/bin/helm 
# Install Terraform
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_RELEASE}/terraform_${TERRAFORM_RELEASE}_linux_amd64.zip && unzip terraform_${TERRAFORM_RELEASE}_linux_amd64.zip && mv terraform /usr/local/bin/ && \
    chmod +x /usr/local/bin/terraform


# Create kubeconfig file
ARG KUBECONFIG_FILE
RUN mkdir -p /root/.kube && \
    echo "${KUBECONFIG_FILE}" > /root/.kube/config && \
    chmod 700 /root/.kube

# add credentials on build and
# make sure your domain is accepted
ARG SSH_PRIVATE_KEY
RUN mkdir -p /root/.ssh/ && \
    echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
    chmod 700 /root/.ssh/id_rsa  && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan XXX.XXX.XXX.XXX>> /root/.ssh/known_hosts
# credentialsId: 'jenkins_ssh_key'

FROM init-jenkins as startup

COPY --from=setup /usr/local/bin/docker-compose /usr/local/bin/docker-compose
COPY --from=setup /usr/local/bin/helm /usr/local/bin/helm
COPY --from=setup /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY --from=setup /usr/local/bin/terraform /usr/local/bin/terraform

COPY --from=setup  /root/.ssh /root/.ssh
COPY --from=setup /root/.kube /root/.kube

# Setup Jenkins init admin User
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

#COPY init groovy scropts
COPY  /init.groovy/ /usr/share/jenkins/ref/init.groovy.d/
# Copy jenkins jobs
COPY /jenkins_home/jobs ${JENKINS_HOME}/jobs
# Copy jenkins views
COPY /jenkins_home/views.xml ${JENKINS_HOME}/config.xml

# Give access to jenkins user
RUN chown -R jenkins:jenkins ${JENKINS_HOME}

RUN chown -R jenkins:jenkins /root

USER jenkins