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

# fzf
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)

  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

  export FZF_DEFAULT_OPTS='
    --height=40%
    --layout=reverse
    --border
    --info=inline
    --prompt="❯ "
    --pointer="▶"
    --marker="✓"
  '

  export FZF_CTRL_T_OPTS='
    --preview "bat --style=numbers --color=always --line-range :200 {} 2>/dev/
null"
  '

  export FZF_ALT_C_OPTS='
    --preview "eza --tree --level=2 --icons --color=always {} 2>/dev/null"
  '
fi

# better CLI tools
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lah --icons --group-directories-first --git'
  alias la='eza -a --icons --group-directories-first'
  alias lt='eza --tree --level=2 --icons --group-directories-first'
  alias lta='eza --tree --level=2 -a --icons --group-directories-first'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
  alias preview='bat --style=numbers --color=always --line-range :200'
fi

if command -v fd >/dev/null 2>&1; then
  alias find='fd'
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
