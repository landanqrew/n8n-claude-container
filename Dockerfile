FROM n8nio/n8n

ARG GH_VERSION=2.90.0
ARG TARGETARCH

USER root

# GitHub CLI
ADD https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${TARGETARCH}.tar.gz /tmp/gh.tar.gz
RUN tar -xzf /tmp/gh.tar.gz -C /tmp \
    && cp "/tmp/gh_${GH_VERSION}_linux_${TARGETARCH}/bin/gh" /usr/local/bin/gh \
    && chmod +x /usr/local/bin/gh \
    && rm -rf /tmp/gh.tar.gz "/tmp/gh_${GH_VERSION}_linux_${TARGETARCH}"

# Claude Code and Codex CLIs
RUN npm install -g @anthropic-ai/claude-code @openai/codex \
    && ln -sf "$(npm prefix -g)/bin/claude" /usr/local/bin/claude \
    && ln -sf "$(npm prefix -g)/bin/codex" /usr/local/bin/codex

USER node
