# dotfiles

Personal development environment configs for WSL2 + WezTerm + Zellij.

## Stack

- **OS**: Windows 10 Pro + WSL2 (Ubuntu)
- **Terminal**: WezTerm (Catppuccin Mocha, Cascadia Code)
- **Multiplexer**: Zellij with custom layouts
- **Shell**: Zsh + Oh My Zsh
- **AI tools**: Claude Code CLI, Codex CLI

## Structure

```
.gitconfig          # Git user config
zsh/.zshrc          # Zsh config with custom aliases and functions
wezterm/wezterm.lua # WezTerm terminal config
zellij/config.kdl   # Zellij keybinds (vim-style, tmux compat)
zellij/layouts/     # Workspace layouts
  myaios.kdl        # 3-tab AI workspace (Claude + Codex + terminal)
  dev.kdl           # Minimal dev layout
  iphone.kdl        # Mobile-friendly layout for Termius
```

## Install

Symlink to the appropriate locations:

```bash
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
ln -sf ~/dotfiles/zellij/config.kdl ~/.config/zellij/config.kdl
ln -sf ~/dotfiles/zellij/layouts/*.kdl ~/.config/zellij/layouts/
```
# Last sync: 2026-04-28T14:40:37Z
