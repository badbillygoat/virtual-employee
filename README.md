# Virtual Employee — Phelix Beeblebrox

An AI executive secretary that monitors a Gmail inbox and replies to emails automatically using Claude Code CLI.

## Architecture

- **VM**: GCP e2-micro (free tier) running Ubuntu 22.04
- **Brain**: Claude Code CLI (included with Claude Pro — fixed $20/month cost)
- **Email**: Gmail API with OAuth 2.0
- **Reliability**: systemd service (auto-starts, auto-restarts)
- **Web search** (optional): Exa MCP

## Files

| File | Purpose |
|------|---------|
| `monitor_email.py` | Main loop — polls Gmail, calls Claude, sends replies |
| `setup_oauth.py` | One-time Gmail OAuth authorization |
| `setup_vm.sh` | Install dependencies on a fresh VM |
| `virtual-employee.service` | systemd service definition |
| `mcp_config.json` | Claude Code MCP config (Exa web search, optional) |
| `credentials.json` | ⚠️ GCP OAuth client secrets — **never commit** (gitignored) |
| `token.json` | ⚠️ Gmail OAuth token — **never commit** (gitignored) |
| `phelix_config.json` | ⚠️ Config Sheet ID cache — **never commit** (gitignored) |

## Whitelists

Both whitelists are stored in a **private Google Sheet** called _"Phelix - Configuration"_ on Phelix's Drive, shared with Oliver as editor. They are **not** stored in this repo.

Phelix auto-creates the sheet on first run and seeds the email whitelist with Oliver's address.

### Managing whitelists (email Oliver from o.t.richman@gmail.com)

**Email whitelist** — who can email Phelix:
- `Add alice@example.com to whitelist`
- `Remove alice@example.com from whitelist`
- `Show whitelist`

**URL / research whitelist** — sites Phelix can research:
- `Add https://example.com to research whitelist`
- `Remove https://example.com from research whitelist`
- `Show research whitelist`

## Setup

See the full setup guide in the project notes.

### Quick update workflow
```bash
# On VM: pull latest code
cd ~/virtual-employee
git pull
sudo systemctl restart virtual-employee
```
