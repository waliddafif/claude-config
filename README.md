# claude-config

Global configuration for [Claude Code](https://claude.ai/claude-code) — skills, settings, and status line.

Works alongside [my-standards](https://github.com/waliddafif/my-standards) which provides the coding rules and CLAUDE.md.

## Installation

### Prerequisites

Clone both repos:

```bash
git clone https://github.com/waliddafif/claude-config.git ~/.claude
git clone https://github.com/waliddafif/my-standards.git ~/Documents/my-standards
```

### Setup

```bash
~/.claude/setup.sh
```

This creates symlinks for `CLAUDE.md` and `commands/` from `my-standards`.
Skills and settings are already in place from the clone.

> **Custom standards path:** `./setup.sh /path/to/my-standards`

### New machine checklist

```
git clone claude-config ~/.claude
git clone my-standards ~/Documents/my-standards
~/.claude/setup.sh
```

---

## Skills

| Skill | Description |
|-------|-------------|
| `dev-workflow` | Best practices de workflow Claude Code |
| `pr-ready` | Vérification complète avant PR |
| `project-init` | Scaffolding de nouveaux projets |
| `security-audit` | Audit de sécurité OWASP |
| `standards-enforcer` | Enforcement automatique des standards de code |
| `techdebt` | Nettoyage dette technique en fin de session |
| `update-standards` | Mise à jour mensuelle des best practices |

Skills are loaded automatically by Claude Code or invoked via `/skill-name`.

### For Claude.ai users

Download the `.zip` files from the [latest release](https://github.com/waliddafif/claude-config/releases/latest) and import them into your Claude.ai project.

To regenerate zips from source:

```bash
./make-zips.sh [output-dir]
# Default output: ~/Downloads/claude-skills/
```

---

## Repository structure

```
~/.claude/
├── skills/               # Claude Code skills
│   ├── dev-workflow/
│   ├── pr-ready/
│   ├── project-init/
│   ├── security-audit/
│   ├── standards-enforcer/
│   ├── techdebt/
│   └── update-standards/
├── settings.json         # Claude Code settings
├── settings.local.json   # Permissions (local overrides)
├── status-line.sh        # Custom status line (model | project | git)
├── setup.sh              # Symlink setup script
├── make-zips.sh          # Generate Claude.ai zip packages
└── .gitignore            # Excludes credentials, sessions, cache
```

**Not tracked in git** (excluded by `.gitignore`):
- `.credentials.json`
- `projects/` (session history)
- `CLAUDE.md` and `commands/` (symlinks recreated by `setup.sh`)

---

## Related

- [my-standards](https://github.com/waliddafif/my-standards) — coding rules, CLAUDE.md, commands
