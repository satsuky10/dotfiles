#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Helper ---
link_file() {
  local src="$1"
  local dest="$2"
  local label
  label="$(basename "$dest")"

  if [ -L "$dest" ]; then
    local current_target
    current_target="$(readlink "$dest")"
    if [ "$current_target" = "$src" ]; then
      echo "  $label: already linked, skipping"
      return
    fi
    echo "  $label: removing old symlink -> $current_target"
    rm "$dest"
  elif [ -e "$dest" ]; then
    echo "  $label: backing up to ${label}.bak"
    mv "$dest" "${dest}.bak"
  fi

  ln -s "$src" "$dest"
  echo "  $label: linked"
}

# --- WezTerm ---
setup_wezterm() {
  local config_dir="$HOME/.config/wezterm"
  local src_dir="$DOTFILES_DIR/.config/wezterm"
  local files=("wezterm.lua" "keybinds.lua")

  echo "Setting up WezTerm..."
  mkdir -p "$config_dir"

  for file in "${files[@]}"; do
    link_file "$src_dir/$file" "$config_dir/$file"
  done

  echo "WezTerm setup done."
}
setup_wezterm

# --- Brewfile ---
setup_brewfile() {
  echo "Setting up Brewfile..."
  link_file "$DOTFILES_DIR/Brewfile" "$HOME/.Brewfile"
}
setup_brewfile

# --- Hammerspoon ---
setup_hammerspoon() {
  local dest_dir="$HOME/.hammerspoon"
  echo "Setting up Hammerspoon..."
  mkdir -p "$dest_dir"
  link_file "$DOTFILES_DIR/.hammerspoon/init.lua" "$dest_dir/init.lua"
}
setup_hammerspoon
