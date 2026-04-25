FROM n8nio/n8n

USER root

RUN apk add --no-cache \
    python3 \
    py3-pip \
    go \
    git \
    curl \
    wget \
    bash \
    jq \
    ripgrep \
    make \
    openssh \
    vim \
    nano \
    tree \
    github-cli

# uv (Python package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Claude CLI
RUN npm install -g @anthropic-ai/claude-code

# Codex CLI
RUN npm install -g @openai/codex

USER node
