#!/bin/sh
set -eu

# Speak up only in a project that uses gmem: a project-level config or .gmem/
# folder at the repository root, or a user-level config that applies everywhere.
# Claude Code may start in a subdirectory, so look at the repository root.
dir="${CLAUDE_PROJECT_DIR:-$PWD}"
root=$(git -C "$dir" rev-parse --show-toplevel 2>/dev/null) || root=$dir

if [ -f "$root/gmem-config.toml" ] || [ -d "$root/.gmem" ] || [ -f "$HOME/.gmem/gmem-config.toml" ]; then
  cat "${CLAUDE_PLUGIN_ROOT}/hooks/session-start-context.md"
fi
