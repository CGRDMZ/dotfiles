FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl git vim wget sudo unzip \
    && rm -rf /var/lib/apt/lists/*

# Install chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# Create user with sudo access
RUN useradd -m testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

CMD ["bash"]
