FROM gitlab/gitlab-runner:latest
WORKDIR /etc/gitlab-runner/

COPY certs /usr/local/share/ca-certificates/
RUN update-ca-certificates && chmod -R 777 /usr/local/share/ca-certificates/

# Make the script executable
COPY custom-entrypoint.sh /usr/local/bin/custom-entrypoint.sh
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

VOLUME ["/etc/gitlab-runner"]
ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
