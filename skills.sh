#!/usr/bin/env bash
# Install every skill in this repo to ~/.claude/skills/<skill-name>/
# Idempotent: safe to re-run. Copies SKILL.md (and any skill assets) into place.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$REPO_DIR/skills"
DEST_DIR="$HOME/.claude/skills"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "error: $SRC_DIR not found" >&2
  exit 1
fi

mkdir -p "$DEST_DIR"

installed=0
for skill_path in "$SRC_DIR"/*/; do
  [[ -d "$skill_path" ]] || continue
  skill_name="$(basename "$skill_path")"
  [[ -f "$skill_path/SKILL.md" ]] || { echo "skip $skill_name (no SKILL.md)"; continue; }

  target="$DEST_DIR/$skill_name"

  # Refuse to overwrite a symlink (e.g. dotfiles-managed install) without confirmation.
  if [[ -L "$target" ]]; then
    echo "skip $skill_name (target is a symlink: $(readlink "$target"))"
    continue
  fi

  mkdir -p "$target"
  # rsync to pick up any future assets (scripts/, resources/) alongside SKILL.md.
  rsync -a --delete "$skill_path" "$target/"
  echo "installed $skill_name → $target"
  installed=$((installed + 1))
done

echo "done: $installed skill(s) installed to $DEST_DIR"
