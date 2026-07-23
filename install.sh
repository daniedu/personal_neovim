#!/usr/bin/env bash
set -euo pipefail

NVIM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

echo "==> personal_neovim installer"
echo ""

# Backup existing config
if [ -d "$NVIM_CONFIG" ]; then
  echo "Backing up existing config to ${NVIM_CONFIG}.bak..."
  mv "$NVIM_CONFIG" "${NVIM_CONFIG}.bak"
fi

# Clone
echo "Cloning personal_neovim..."
git clone https://github.com/daniedu/personal_neovim "$NVIM_CONFIG"

# System deps
if command -v apt-get &>/dev/null; then
  echo "Installing system dependencies (ripgrep)..."
  sudo apt-get update -qq && sudo apt-get install -y -qq ripgrep
fi

# Install plugins
echo "Installing Neovim plugins..."
nvim --headless "+Lazy! sync" +qa

# Install LSP servers & formatters
echo "Installing LSP servers and formatters via Mason..."
nvim --headless "+MasonInstall clangd tailwindcss-language-server typescript-language-server prettierd stylua gofumpt nixfmt php-cs-fixer shfmt eslint_d" +qa

echo ""
echo "==> Done! Run 'nvim' to start."
