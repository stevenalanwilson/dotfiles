# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Oh My Zsh ────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Theme handled by Powerlevel10k below

plugins=(git z)

source $ZSH/oh-my-zsh.sh 2>/dev/null || true

# ── Powerlevel10k ─────────────────────────────────────────────────────────────
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ── Editor ────────────────────────────────────────────────────────────────────
export EDITOR="code --wait"
export VISUAL="code --wait"

# ── PATH ──────────────────────────────────────────────────────────────────────
eval "$(fnm env --use-on-cd --shell zsh)"

export PATH="$PATH:/Users/stevenwilson/.local/bin"
export PATH="/Users/stevenwilson/.antigravity/antigravity/bin:$PATH"
export PATH="/Users/stevenwilson/.antigravity-ide/antigravity-ide/bin:$PATH"

# ── Options & history ─────────────────────────────────────────────────────────
[[ -f ~/.zsh_options ]] && source ~/.zsh_options

# ── Aliases ───────────────────────────────────────────────────────────────────
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# ── Functions ─────────────────────────────────────────────────────────────────
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions

# ── Cheatsheet ────────────────────────────────────────────────────────────────
[[ -f ~/.zsh_cheatsheet ]] && source ~/.zsh_cheatsheet

# ── fzf — fuzzy finder ────────────────────────────────────────────────────────
source <(fzf --zsh)

# ── zoxide — smart cd ─────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"

# ── zsh-autosuggestions ───────────────────────────────────────────────────────
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ── zsh-syntax-highlighting (must be last) ────────────────────────────────────
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
