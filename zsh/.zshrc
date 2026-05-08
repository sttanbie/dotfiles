# PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR=nano

# Auto-start Zellij ao conectar via SSH (Termius iPhone)
if [[ -n "$SSH_CONNECTION" ]] && [[ -z "$ZELLIJ" ]]; then
    zellij -s iphone --layout iphone 2>/dev/null || zellij attach iphone
fi

# Dev aliases
alias v="nvim"
alias ll="ls -lah"
alias gs="git status"
alias dev="zellij --layout ~/.config/zellij/layouts/dev.kdl"
alias projetos="cd /mnt/d/Projetos/"
function workon() { cd "/mnt/d/Projetos/$1" && nvim .; }

# npm global
export PATH="$HOME/.npm-global/bin:$PATH"

# Cargo / Rust
export PATH="$HOME/.cargo/bin:$PATH"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Zellij: renomear tab com nome da pasta ao fazer cd
zellij_tab_name_update() {
  if [[ -n $ZELLIJ ]]; then
    # zellij action rename-tab "${PWD##*/}" 2>/dev/null
  fi
}
zellij_tab_name_update
chpwd_functions+=(zellij_tab_name_update)

# WezTerm tab naming
function tab() {
  "/mnt/c/Program Files/WezTerm/wezterm.exe" cli set-tab-title "$1" 2>/dev/null
}

# Screenshot: Win+Shift+S then type "sshot" to paste as Claude message
sshot() {
  local f="/tmp/ss-$(date +%s).png"
  powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; \$img=[System.Windows.Forms.Clipboard]::GetImage(); if(\$img){\$img.Save('$(wslpath -w $f)')} else {Write-Host 'NO_IMAGE'}" 2>/dev/null
  if [ -f "$f" ]; then
    echo "veja $f"
  else
    echo "Nenhuma imagem no clipboard. Tire o print primeiro (Win+Shift+S)."
  fi
}

# Zellij socket + auto-attach
export ZELLIJ_SOCKET_DIR=/tmp/zj
if [[ -z "$ZELLIJ" ]]; then
    ZELLIJ_SOCKET_DIR=/tmp/zj zellij attach MyAIOS 2>/dev/null || ZELLIJ_SOCKET_DIR=/tmp/zj zellij --session MyAIOS --layout ~/.config/zellij/layouts/myaios.kdl
fi
alias myaios="ZELLIJ_SOCKET_DIR=/tmp/zj zellij attach MyAIOS 2>/dev/null || ZELLIJ_SOCKET_DIR=/tmp/zj zellij --session MyAIOS --layout ~/.config/zellij/layouts/myaios.kdl"
alias claude="XDG_CONFIG_HOME=\$PWD/.config claude"

# Codex wrapper
unalias codex 2>/dev/null
codex() {
  python3 "$HOME/.codex/skills/codex-memory/scripts/codex_auto.py" "$@"
}

# bun completions
[ -s "/home/sttanbie/.bun/_bun" ] && source "/home/sttanbie/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# claude-mem plugin
alias claude-mem='/home/sttanbie/.bun/bin/bun "/home/sttanbie/.claude/plugins/cache/thedotmack/claude-mem/12.3.9/scripts/worker-service.cjs"'

# GitMon post-push hooks — trigger after successful real git push commands
_gitmon_run_post_push_hooks() {
  emulate -L zsh

  if [[ -x "$HOME/.claude/hooks/gitmon-feed-mirror.sh" ]]; then
    "$HOME/.claude/hooks/gitmon-feed-mirror.sh" || true
  fi

  if [[ -x "$HOME/.claude/hooks/gitmon-xp-boost.sh" ]]; then
    "$HOME/.claude/hooks/gitmon-xp-boost.sh" || true
  fi
}

_gitmon_git_subcommand() {
  emulate -L zsh
  local expects_value=0 arg

  for arg in "$@"; do
    if (( expects_value )); then
      expects_value=0
      continue
    fi

    case "$arg" in
      --)
        break
        ;;
      -c|-C|--exec-path|--git-dir|--work-tree|--namespace|--super-prefix|--config-env)
        expects_value=1
        ;;
      --exec-path=*|--git-dir=*|--work-tree=*|--namespace=*|--super-prefix=*|--config-env=*)
        ;;
      -*)
        ;;
      *)
        print -r -- "$arg"
        return 0
        ;;
    esac
  done

  return 1
}

_gitmon_should_mirror_push() {
  emulate -L zsh
  local after_push=0 arg

  for arg in "$@"; do
    if (( after_push )); then
      case "$arg" in
        -n|--dry-run|-h|--help)
          return 1
          ;;
      esac
      continue
    fi

    if [[ "$arg" == "push" ]]; then
      after_push=1
    fi
  done

  return 0
}

git() {
  emulate -L zsh
  local subcommand

  subcommand="$(_gitmon_git_subcommand "$@")" || {
    command git "$@"
    return $?
  }

  if [[ "$subcommand" != "push" ]]; then
    command git "$@"
    return $?
  fi

  command git "$@"
  local exit_code=$?
  if (( exit_code == 0 )) && _gitmon_should_mirror_push "$@"; then
    _gitmon_run_post_push_hooks
  fi
  return $exit_code
}

gpush() {
  git push "$@"
}

# Secrets (not tracked in dotfiles repo)
[ -f "$HOME/.env.secrets" ] && source "$HOME/.env.secrets"
