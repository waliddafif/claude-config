#!/bin/bash
# Custom Status Line
# Shows: Model | Project | Git Branch | Modified files count

# Get current model from env or default
MODEL=${CLAUDE_MODEL:-"opus"}

# Detect project from current directory name
PROJECT=$(basename "$PWD")

# Get git branch if in a repo
if git rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git branch --show-current 2>/dev/null || echo "detached")
  MODIFIED=$(git diff --name-only 2>/dev/null | wc -l | tr -d ' ')
  STAGED=$(git diff --cached --name-only 2>/dev/null | wc -l | tr -d ' ')
  GIT_INFO="$BRANCH | ${MODIFIED}m ${STAGED}s"
else
  GIT_INFO="no-git"
fi

echo "$MODEL | $PROJECT | $GIT_INFO"
