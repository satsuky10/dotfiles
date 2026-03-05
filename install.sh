#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- WezTerm ---
setup_wezterm() {
  local config_dir="$HOME/.config/wezterm"
  local src_dir="$DOTFILES_DIR/.config/wezterm"
  local files=("wezterm.lua" "keybinds.lua")

  echo "Setting up WezTerm..."

  mkdir -p "$config_dir"

  for file in "${files[@]}"; do
    local src="$src_dir/$file"
    local dest="$config_dir/$file"

    if [ -L "$dest" ]; then
      local current_target
      current_target="$(readlink "$dest")"
      if [ "$current_target" = "$src" ]; then
        echo "  $file: already linked, skipping"
        continue
      fi
      echo "  $file: removing old symlink -> $current_target"
      rm "$dest"
    elif [ -e "$dest" ]; then
      echo "  $file: backing up to ${file}.bak"
      mv "$dest" "${dest}.bak"
    fi

    ln -s "$src" "$dest"
    echo "  $file: linked"
  done

  echo "WezTerm setup done."
}

setup_wezterm

# --- Brewfile ---
setup_brewfile() {
  local src="$DOTFILES_DIR/Brewfile"
  local dest="$HOME/.Brewfile"
  echo "Setting up Brewfile..."
  if [ -L "$dest" ]; then
    local current_target
    current_target="$(readlink "$dest")"
    if [ "$current_target" = "$src" ]; then
      echo "  .Brewfile: already linked, skipping"
      return
    fi
    echo "  .Brewfile: removing old symlink -> $current_target"
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "  .Brewfile: backing up to Brewfile.bak"
    mv "$dest" "${dest}.bak"
  fi
  ln -s "$src" "$dest"
  echo "  .Brewfile: linked"
}
setup_brewfile
