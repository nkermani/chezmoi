# Chezmoi Dotfiles

My personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Initial Setup

On a new machine, run these commands to set up chezmoi with this repo:

```bash
# Install chezmoi
sh -c "$(curl -fsSL https://get.chezmoi.io)"

# Initialize chezmoi with this repo
chezmoi init https://github.com/nkermani/chezmoi.git

# Apply the dotfiles
chezmoi apply

# Or for interactive mode
chezmoi apply -i
```

## Template Variables

### `is_42`

Boolean that indicates whether the machine is a 42 school computer.

- Set to `true` for 42 school computers (intra-*.42.fr machines)
- Set to `false` for personal/macOS machines

This variable is used to conditionally include/exclude:
- `.nkermani/bin/42` - Focus mode scripts
- `.local/share/applications/42-*.desktop` - Desktop entry files

### `has_sudo`

Boolean that indicates whether the user has sudo access.

- Set to `true` if you can run `sudo` commands
- Set to `false` otherwise (like on 42 school machines)

## Configuration

Template variables are configured in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
  is_42 = true
  has_sudo = false
```