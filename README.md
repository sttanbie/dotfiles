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
.gitconfig              # Git user config + gh credential + pushfeed alias
zsh/.zshrc              # Zsh config with aliases, functions, GitMon hooks
wezterm/wezterm.lua     # WezTerm terminal config
zellij/config.kdl       # Zellij keybinds (vim-style, tmux compat)
zellij/layouts/         # Workspace layouts
  myaios.kdl            # 3-tab AI workspace (Claude + Codex + terminal)
  dev.kdl               # Minimal dev layout (shell + logs + claude)
  iphone.kdl            # Mobile-friendly layout for Termius
```

## Aliases & Functions

| Alias/Function | What it does |
|---|---|
| `v` | nvim |
| `ll` | ls -lah |
| `gs` | git status |
| `dev` | Opens Zellij with dev layout |
| `projetos` | cd /mnt/d/Projetos/ |
| `workon <name>` | cd into project + open nvim |
| `myaios` | Attach/create MyAIOS Zellij session |
| `claude` | Claude CLI with per-project config |
| `codex` | Codex CLI via memory wrapper |
| `sshot` | Grab Win clipboard screenshot for Claude |
| `tab <name>` | Rename WezTerm tab |
| `gpush` | git push with GitMon hooks |
| `claude-mem` | Claude memory plugin worker |

## Keybinds (Zellij)

All modes use vim-style `hjkl` + arrow keys. `clear-defaults=true`.

| Shortcut | Action |
|---|---|
| `Ctrl g` | Toggle locked mode |
| `Ctrl p` | Pane mode |
| `Ctrl t` | Tab mode |
| `Ctrl n` | Resize mode |
| `Ctrl h` | Move mode |
| `Ctrl s` | Scroll mode |
| `Ctrl o` | Session mode |
| `Ctrl b` | Tmux mode |
| `Alt f` | Toggle floating panes |
| `Alt n` | New pane |
| `Alt hjkl` | Move focus between panes |

## GitMon Integration

The `.zshrc` wraps `git` to trigger post-push hooks automatically:
- `gitmon-feed-mirror.sh` — mirrors push events
- `gitmon-xp-boost.sh` — XP tracking

## Secrets

API keys and tokens live in `~/.env.secrets` (not tracked). The `.zshrc` sources it at the end.

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
