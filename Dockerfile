# Extend the base code-server image from LinuxServer
FROM lscr.io/linuxserver/code-server:latest

USER root

# Update package list and install wget and sudo
RUN apt-get update && apt-get install -y wget sudo

# Install Go 1.24
RUN wget https://go.dev/dl/go1.24.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.24.linux-amd64.tar.gz \
    && rm go1.24.linux-amd64.tar.gz

# Update PATH so that the Go binary is available
ENV PATH="/usr/local/go/bin:${PATH}"

# (Optional) Create a non-root user with sudo privileges.
RUN useradd -m coder && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch back to the default non-root user expected by code-server.
USER nexus
