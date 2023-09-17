# Use an official base image with your desired Linux distribution.
FROM ubuntu:20.04

# Install dependencies and required tools.
RUN apt-get update
RUN apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Install the Azure DevOps agent.
ARG AGENT_VERSION=3.225.0
RUN curl -o /tmp/agent.tar.gz https://vstsagentpackage.azureedge.net/agent/${AGENT_VERSION}/vsts-agent-linux-x64-${AGENT_VERSION}.tar.gz && \
    mkdir -p /agent && \
    tar -xzvf /tmp/agent.tar.gz -C /agent --strip-components 1 && \
    rm /tmp/agent.tar.gz

# Set the working directory.
WORKDIR /agent

ENV AGENT_ALLOW_RUNASROOT=true

# Install Packages to the agent
ARG DOTNET_VERSION=6.0
## Install Dotent SDK
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb

RUN apt-get update && \
   apt-get install -y dotnet-sdk-${DOTNET_VERSION}

# Install linux packages
RUN apt-get install -y git jq && \
    rm -rf /var/lib/apt/lists/*

# Run the Azure DevOps agent.
ENTRYPOINT ["bash", "-c"]
CMD ["./config.sh --unattended && ./run.sh"]

