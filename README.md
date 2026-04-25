# My Dotfiles

Personal configuration managed with [chezmoi](https://www.chezmoi.io/).

## Install

```bash
sh -c "$(curl -sfL https://get.chezmoi.io)" -b ~/.local/bin
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## Setup

Initialize with my dotfiles repo:

```bash
chezmoi init https://github.com/nkermani/chezmoi
```

Apply the config:

```bash
chezmoi apply
```

## Usage

```bash
chezmoi edit ~/.zshrc    # Edit source file
chezmoi apply           # Apply changes
chezmoi diff            # Show pending changes
chezmoi status          # Show state
```