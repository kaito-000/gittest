#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0
FORCE=0

usage() {
  cat <<'USAGE'
Usage: scripts/bootstrap.sh [--dry-run] [--force] [--help]

Create symlinks from this dotfiles repository into $HOME.

Options:
  --dry-run  Print actions without changing files.
  --force    Replace existing non-target symlinks after backing them up.
  --help     Show this help.
USAGE
}

log() {
  printf '%s\n' "$*"
}

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '[dry-run] %q' "$1"
    shift
    for arg in "$@"; do
      printf ' %q' "$arg"
    done
    printf '\n'
  else
    "$@"
  fi
}

resolve_path() {
  local path="$1"

  if command -v realpath >/dev/null 2>&1; then
    realpath "$path"
  else
    cd "$(dirname "$path")"
    local base
    base="$(basename "$path")"
    printf '%s/%s\n' "$(pwd -P)" "$base"
  fi
}

backup_path() {
  local target="$1"
  local backup_root="$2"
  local rel="${target#$HOME/}"
  local dest="$backup_root/$rel"

  run mkdir -p "$(dirname "$dest")"
  run mv "$target" "$dest"
  log "backed up: $target -> $dest"
}

link_path() {
  local source="$1"
  local target="$2"
  local backup_root="$3"

  if [[ ! -e "$source" ]]; then
    log "missing source: $source"
    return 1
  fi

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"

    if [[ "$current" == "$source" ]]; then
      log "already linked: $target -> $source"
      return 0
    fi

    if [[ "$FORCE" -ne 1 ]]; then
      log "skip existing symlink: $target -> $current"
      log "  rerun with --force to replace it after backup"
      return 0
    fi

    backup_path "$target" "$backup_root"
  elif [[ -e "$target" ]]; then
    backup_path "$target" "$backup_root"
  fi

  run mkdir -p "$(dirname "$target")"
  run ln -s "$source" "$target"
  log "linked: $target -> $source"
}

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=1
      ;;
    --force)
      FORCE=1
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      log "unknown option: $arg"
      usage
      exit 2
      ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd -P)"
BACKUP_ROOT="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
OS_NAME="$(uname -s)"

log "dotfiles: $DOTFILES_DIR"
log "home:     $HOME"
if [[ "$DRY_RUN" -eq 1 ]]; then
  log "mode:     dry-run"
fi

link_path "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc" "$BACKUP_ROOT"
link_path "$DOTFILES_DIR/nvim" "$HOME/.config/nvim" "$BACKUP_ROOT"
link_path "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua" "$BACKUP_ROOT"
link_path "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml" "$BACKUP_ROOT"

if [[ "$OS_NAME" == "Darwin" ]]; then
  link_path "$DOTFILES_DIR/zsh/.zshprofile.macos" "$HOME/.zprofile" "$BACKUP_ROOT"
fi

log "done"
