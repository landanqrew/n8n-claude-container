# n8n + Claude Code + Codex Container

A Docker setup for running [n8n](https://n8n.io/) with [Claude Code](https://docs.anthropic.com/en/docs/claude-code) and [Codex CLI](https://github.com/openai/codex).

## Included Tools

- Node.js
- Git, GitHub CLI, ssh, tree
- Claude Code CLI
- Codex CLI

## Setup

1. Copy the example compose file:

   ```bash
   cp docker-compose-example.yml docker-compose.yml
   ```

2. Edit `docker-compose.yml`:
   - Set a secure password for `N8N_BASIC_AUTH_PASSWORD`
   - Set your timezone in `GENERIC_TIMEZONE`
   - Mount any repos you want accessible under the `volumes` section:
     ```yaml
     - /path/to/your/repo:/home/node/repos/repo-name
     ```

3. Build and start the container:

   ```bash
   docker compose up -d --build
   ```

4. Access n8n at `http://localhost:5678`

## Using Claude Code

Shell into the container:

```bash
docker compose exec n8n sh
```

Then run `claude` in any mounted repo:

```bash
cd /home/node/repos/repo-name
claude
```

## Using Codex

Shell into the container:

```bash
docker compose exec n8n sh
```

Then run `codex` in any mounted repo:

```bash
cd /home/node/repos/repo-name
codex
```

To use your ChatGPT subscription instead of manually configuring an API key, run the login flow once:

```bash
codex login
```

Choose "Sign in with ChatGPT" and complete the browser flow. The compose file mounts `~/.codex` into the container so the login persists across rebuilds.

## Using GitHub CLI

Shell into the container:

```bash
docker compose exec n8n sh
```

Then authenticate GitHub CLI:

```bash
gh auth login
```

The compose file mounts `~/.config/gh` into the container so the login persists across rebuilds.

## Prerequisites

- Docker and Docker Compose
- A valid Claude Code authentication (`~/.claude`)
- A valid Codex authentication (`~/.codex`), created with `codex login`
- A valid GitHub CLI authentication (`~/.config/gh`), created with `gh auth login`
