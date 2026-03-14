#!/bin/bash
set -e

SKILL_SRC="$(cd "$(dirname "$0")/nvim-setup" && pwd)"
SKILL_DST="$HOME/.claude/skills/nvim-setup"

mkdir -p "$SKILL_DST"

rsync -av --delete \
  --exclude='evals/' \
  "$SKILL_SRC/" "$SKILL_DST/"

echo "✓ Installed to $SKILL_DST"
