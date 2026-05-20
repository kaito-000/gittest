# mise
if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# prompt
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# directory jump
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fuzzy finder
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# platform
case "$(uname -s)" in
  Darwin)
    export BROWSER="open"
    alias pbcopy='pbcopy'
    alias pbpaste='pbpaste'
    ;;
  Linux)
    if grep -qi microsoft /proc/version 2>/dev/null; then
      export BROWSER="wslview"
      alias pbcopy='clip.exe'
      alias pbpaste='powershell.exe -NoProfile -Command Get-Clipboard'
    fi
    ;;
esac

# tools
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lah --icons --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

if command -v rg >/dev/null 2>&1; then
  alias grep='rg'
fi

# editor / codex
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias cdx='codex'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# git
alias gs='git status --short'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate --all -20'

export PATH="$(aube bin -g):$PATH"
