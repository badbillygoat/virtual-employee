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
| `mcp_config.json` | Claude Code MCP config (Exa web search) |
| `credentials.json` | ⚠️ GCP OAuth client secrets — **never commit** |
| `token.json` | ⚠️ Gmail OAuth token — **never commit** |

## Setup

See the full setup guide in the project notes.

### Quick update workflow
```bash
# On VM: pull latest code
cd ~/virtual-employee
git pull
sudo systemctl restart virtual-employee
```
