#!/usr/bin/env zsh
# dotfiles/macos.sh — macOS system preferences
# Run once after a fresh install. Requires logout/restart to take full effect.
# Usage: zsh macos.sh

echo "▶ Setting macOS defaults..."

# ── Finder ────────────────────────────────────────────────────────────────────
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Show path bar at bottom of Finder
defaults write com.apple.finder ShowPathbar -bool true
# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable warning when changing file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Keep folders on top when sorting
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# ── Keyboard ──────────────────────────────────────────────────────────────────
# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Disable smart quotes and dashes (annoying in terminal/code)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# ── Screenshots ───────────────────────────────────────────────────────────────
# Save to ~/Desktop/Screenshots
mkdir -p "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"
# Save as PNG
defaults write com.apple.screencapture type -string "png"
# Disable shadow
defaults write com.apple.screencapture disable-shadow -bool true

# ── Dock ──────────────────────────────────────────────────────────────────────
# Auto-hide the dock
defaults write com.apple.dock autohide -bool true
# Faster dock show/hide animation
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 0.4
# Don't show recent apps
defaults write com.apple.dock show-recents -bool false
# Smaller icon size
defaults write com.apple.dock tilesize -int 48

# ── Trackpad ──────────────────────────────────────────────────────────────────
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# ── Menu bar ──────────────────────────────────────────────────────────────────
# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
# 24-hour clock
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# ── Activity Monitor ──────────────────────────────────────────────────────────
# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0
# CPU usage as dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# ── Safari (useful even if you use Chrome) ────────────────────────────────────
# Show full URL
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# ── Restart affected apps ─────────────────────────────────────────────────────
for app in "Finder" "Dock" "SystemUIServer" "Safari"; do
  killall "$app" &>/dev/null || true
done

echo "✓ macOS defaults applied. Some changes require a logout to take full effect."
