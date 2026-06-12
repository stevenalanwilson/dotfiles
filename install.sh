#!/usr/bin/env zsh
# dotfiles/install.sh — Steven Wilson
# Run this on a fresh Mac to install everything from scratch.
# Usage: zsh install.sh

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

step() { echo "${YELLOW}▶ $1${NC}"; }
done_() { echo "${GREEN}✓ $1${NC}"; }

# ── 1. Xcode CLI tools ────────────────────────────────────────────────────────
step "Checking Xcode CLI tools"
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "  Install Xcode CLI tools, then re-run this script."
  exit 1
fi
done_ "Xcode CLI tools present"

# ── 2. Homebrew ───────────────────────────────────────────────────────────────
step "Checking Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
done_ "Homebrew ready"

# ── 3. Brew packages ──────────────────────────────────────────────────────────
step "Installing Homebrew packages"
brew install \
  git gh \
  fnm \
  fzf zsh-autosuggestions zsh-syntax-highlighting \
  eza bat zoxide fd ripgrep \
  pipx uv \
  terraform
done_ "Homebrew packages installed"

# ── 4. Oh My Zsh ──────────────────────────────────────────────────────────────
step "Checking Oh My Zsh"
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  RUNZSH=no CHSH=no \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
done_ "Oh My Zsh ready"

# ── 5. Powerlevel10k ──────────────────────────────────────────────────────────
step "Checking Powerlevel10k"
P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi
done_ "Powerlevel10k ready"

# ── 6. Symlink dotfiles ───────────────────────────────────────────────────────
step "Symlinking dotfiles"

symlink() {
  local src="$DOTFILES/$1"
  local dst="$HOME/$2"
  if [[ -f "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "${dst}.bak"
    echo "  Backed up existing $2 → ${2}.bak"
  fi
  ln -sf "$src" "$dst"
  echo "  $dst → $src"
}

symlink zshrc        .zshrc
symlink zsh_aliases  .zsh_aliases
symlink p10k.zsh     .p10k.zsh

done_ "Dotfiles symlinked"

# ── 7. Node via fnm ───────────────────────────────────────────────────────────
step "Installing Node LTS via fnm"
eval "$(fnm env)"
fnm install --lts
fnm default lts-latest
done_ "Node $(node -v) ready"

# ── 8. Done ───────────────────────────────────────────────────────────────────
echo ""
echo "${GREEN}All done! Open a new terminal tab to load your shell.${NC}"
echo "Run 'p10k configure' if you want to customise your prompt."
