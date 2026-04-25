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

### SSH Setup

If using SSH authentication:

```bash
cd ~/.local/share/chezmoi
git remote set-url origin git@github.com:nkermani/chezmoi.git
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

## Nix Setup (42 Machines)

On 42 school machines, nix is installed via nix-user-chroot. Here's how to set it up:

### Automated Setup (Recommended)

If you use chezmoi with home-manager, after running `chezmoi apply` you'll find `~/.config/home-manager/install.sh`:

```bash
~/.config/home-manager/install.sh
```

This script:
1. Downloads the nix-user-chroot binary
2. Sets up PATH in `.bash_profile`
3. Installs nix
4. Installs and configures home-manager

### Manual Setup

If you prefer to set it up manually:

#### Prerequisites

1. Download `nix-user-chroot` binary:
   ```bash
   curl -L https://github.com/nix-community/nix-user-chroot/releases/download/2.1.1/nix-user-chroot-bin-2.1.1-x86_64-unknown-linux-musl -o ~/nix-user-chroot
   chmod +x ~/nix-user-chroot
   ```
2. Ensure `~/.nix` directory exists with nix store

#### Running Nix Commands

```bash
~/nix-user-chroot ~/.nix <command>
# Example: ~/nix-user-chroot ~/.nix nix --version
```

### Kitty Integration

Home-manager automatically configures kitty to use nix via `~/.config/home-manager/kitty/session.conf`. It will:

- Download the nix-user-chroot binary
- Configure kitty to launch in the nix environment

If you need to configure it manually, create `~/.config/kitty/session.conf`:

```bash
launch ~/nix-user-chroot ~/.nix bash -l -c 'source ~/.nix-profile/etc/profile.d/nix-daemon.sh && exec bash'
```

This launches bash in the nix environment on every kitty terminal.

### Manual Nix Usage

```bash
# Enter nix environment
~/nix-user-chroot ~/.nix bash

# Run a single nix command
~/nix-user-chroot ~/.nix nix <command>

# Use nix-shell
~/nix-user-chroot ~/.nix nix-shell -p <package>
```

### Configuration

Template variables are configured in `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
  is_42 = true
  has_sudo = false
```