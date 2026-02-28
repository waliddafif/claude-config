#!/bin/bash
# Setup Claude Code global config
# Usage: git clone claude-config ~/.claude && ~/.claude/setup.sh

set -e

CLAUDE_DIR="$(cd "$(dirname "$0")" && pwd)"
STANDARDS_DIR="${1:-$HOME/Documents/my-standards}"

if [ ! -d "$STANDARDS_DIR" ]; then
  echo "❌ $STANDARDS_DIR not found."
  echo "Clone it first: git clone https://github.com/waliddafif/my-standards.git $STANDARDS_DIR"
  exit 1
fi

echo "Setting up Claude Code config..."
echo "  Claude dir:    $CLAUDE_DIR"
echo "  Standards dir: $STANDARDS_DIR"

# CLAUDE.md symlink
ln -sf "$STANDARDS_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
echo "  ✓ CLAUDE.md → $STANDARDS_DIR/CLAUDE.md"

# Commands symlinks
mkdir -p "$CLAUDE_DIR/commands"
for cmd in "$STANDARDS_DIR/commands/"*.md; do
  name=$(basename "$cmd")
  ln -sf "$cmd" "$CLAUDE_DIR/commands/$name"
  echo "  ✓ commands/$name → $cmd"
done

# Ensure skills and settings are in place (already from git clone)
echo ""
echo "✅ Setup complete. Skills, settings, and status-line ready."
echo ""
echo "Next steps:"
echo "  cd your-project && claude"
