FROM node:22-bookworm-slim

ARG N8N_VERSION=latest
ARG GH_VERSION=2.90.0
ARG TARGETARCH

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bash \
        ca-certificates \
        curl \
        git \
        tini \
    && rm -rf /var/lib/apt/lists/*

# GitHub CLI
RUN curl -fsSL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${TARGETARCH}.tar.gz" -o /tmp/gh.tar.gz \
    && tar -xzf /tmp/gh.tar.gz -C /tmp \
    && cp "/tmp/gh_${GH_VERSION}_linux_${TARGETARCH}/bin/gh" /usr/local/bin/gh \
    && chmod +x /usr/local/bin/gh \
    && rm -rf /tmp/gh.tar.gz "/tmp/gh_${GH_VERSION}_linux_${TARGETARCH}"

# n8n, Claude Code, and Codex CLIs
RUN npm install -g "n8n@${N8N_VERSION}" @anthropic-ai/claude-code @openai/codex \
    && ln -sf "$(npm prefix -g)/bin/claude" /usr/local/bin/claude \
    && ln -sf "$(npm prefix -g)/bin/codex" /usr/local/bin/codex

WORKDIR /home/node
USER node

EXPOSE 5678

ENTRYPOINT ["tini", "--"]
CMD ["n8n"]
