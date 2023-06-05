FROM jenkins/jenkins:lts

# Skip install plugins wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# JAVA mem heap size (examples -Xmx512m -Xmx512g ...)
ENV JAVA_OPTS -Xms2g -Xmx3g
# Install jenkins plugins
RUN jenkins-plugin-cli --plugins configuration-as-code
# Init script to create default admin user
COPY /jenkins/init/scripts /usr/share/jenkins/ref/init.groovy.d/
# This is the user by default in docker image
# USER jenkins
# Use root user to run additional commands that require permiossions
USER root
RUN chown -R jenkins:jenkins $JENKINS_HOME