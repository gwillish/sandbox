FROM swift:6.2

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt -q update \
    && apt -q dist-upgrade -y \
    && apt -q install -y curl vim \
    && apt-get install -y libjemalloc-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a hummingbird user and group with /app as its home directory
WORKDIR /home/ubuntu
USER ubuntu
RUN mkdir -p /home/ubuntu/.gemini
COPY .bash_profile /home/ubuntu/.bash_profile
RUN chown -R ubuntu:ubuntu /home/ubuntu

# NODEJS via NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
ENV NVM_DIR=/home/ubuntu/.nvm
RUN NVM_DIR=/home/ubuntu/.nvm && . "$NVM_DIR/nvm.sh" && nvm install --lts

# Gemini CLI
RUN NVM_DIR=/home/ubuntu/.nvm && . "$NVM_DIR/nvm.sh" && npm install -g @google/gemini-cli
COPY .gemini/settings.json /home/ubuntu/.gemini/settings.json
COPY .gemini/trustedFolders.json /home/ubuntu/.gemini/trustedFolders.json
RUN chown -R ubuntu:ubuntu /home/ubuntu/.gemini
