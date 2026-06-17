#!/usr/bin/env zsh
# dotfiles/install.sh — Steven Wilson
# Run on a fresh Mac to install everything from scratch.
# Usage: zsh install.sh

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

step()  { echo "\n${YELLOW}▶ $1${NC}"; }
done_() { echo "${GREEN}✓ $1${NC}"; }
info()  { echo "${BLUE}  $1${NC}"; }

# ── 1. Xcode CLI tools ────────────────────────────────────────────────────────
step "Checking Xcode CLI tools"
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "  Install Xcode CLI tools then re-run this script."
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

# ── 3. Brew bundle ────────────────────────────────────────────────────────────
step "Installing packages from Brewfile"
brew bundle install --file="$DOTFILES/Brewfile"
done_ "Brewfile packages installed"

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
  mkdir -p "$(dirname "$dst")"
  if [[ -f "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "${dst}.bak"
    info "Backed up $2 → ${2}.bak"
  fi
  ln -sf "$src" "$dst"
  info "$dst → $src"
}

symlink zshrc            .zshrc
symlink zsh_aliases      .zsh_aliases
symlink zsh_options      .zsh_options
symlink zsh_functions    .zsh_functions
symlink zsh_cheatsheet   .zsh_cheatsheet
symlink p10k.zsh         .p10k.zsh
symlink gitconfig        .gitconfig
symlink gitignore_global .gitignore_global
symlink npmrc            .npmrc
symlink ssh_config       .ssh/config

done_ "Dotfiles symlinked"

# ── 7. bat theme ──────────────────────────────────────────────────────────────
step "Installing bat Catppuccin theme"
mkdir -p "$(bat --config-dir)/themes"
curl -sL "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme" \
  -o "$(bat --config-dir)/themes/Catppuccin-Mocha.tmTheme"
bat cache --build &>/dev/null
symlink bat_config "$(bat --config-dir | sed "s|$HOME/||")/config"
done_ "bat theme installed"

# ── 8. Node via fnm ───────────────────────────────────────────────────────────
step "Installing Node LTS via fnm"
eval "$(fnm env)"
fnm install --lts
fnm default lts-latest
done_ "Node $(node -v) ready"

# ── 9. gh config ──────────────────────────────────────────────────────────────
step "Configuring gh CLI"
gh config set editor "code --wait"
gh config set git_protocol ssh
done_ "gh configured"

# ── 10. macOS defaults (optional) ────────────────────────────────────────────
step "macOS system defaults"
read "reply?Apply macOS defaults (keyboard, Finder, Dock, screenshots)? [y/N] "
if [[ "$reply" =~ ^[Yy]$ ]]; then
  zsh "$DOTFILES/macos.sh"
else
  info "Skipped — run 'zsh ~/dotfiles/macos.sh' any time"
fi

# ── 11. Done ──────────────────────────────────────────────────────────────────
echo "\n${GREEN}All done!${NC}"
echo "  • Open a new terminal tab to load your shell"
echo "  • Run 'p10k configure' to customise your prompt"
echo "  • Sign in to 1Password and enable SSH agent: Settings → Developer → SSH Agent"
