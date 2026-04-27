# PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

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

# npm global
export PATH=~/.npm-global/bin:$PATH

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

# bun
[ -s "/home/sttanbie/.bun/_bun" ] && source "/home/sttanbie/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
