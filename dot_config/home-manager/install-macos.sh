# dot_config/home-manager/install-macos.sh

NIX_BIN="/nix/var/nix/profiles/default/bin"

if [ -f "${NIX_BIN}/nix-channel" ]; then
	echo "Nix is already installed, skipping"
else
	curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
	bash /tmp/nix-install.sh
	rm /tmp/nix-install.sh
fi

export PATH="${NIX_BIN}:${PATH}"

# Enable Nix daemon for single-user mode
echo "Enabling Nix daemon..."
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true

# Wait for daemon to start
sleep 2

# Setup bash PATH
echo "Setting up PATH for bash"

if ! grep -q 'nix.sh' "${HOME}/.bash_profile"; then
	echo "Adding nix.sh to .bash_profile"

	cat >>"${HOME}/.bash_profile" <<'EOF'
if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix.sh" ]; then
    . "/nix/var/nix/profiles/default/etc/profile.d/nix.sh"
fi
EOF
else
	echo "nix.sh is already in .bash_profile, skipping"
fi

# Source nix.sh for current session
if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix.sh" ]; then
	. "/nix/var/nix/profiles/default/etc/profile.d/nix.sh"
fi

# Enabling home-manager
echo "Enabling home-manager for the current user"
${NIX_BIN}/nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
${NIX_BIN}/nix-channel --update
${NIX_BIN}/nix-shell '<home-manager>' -A install

# Remove base home-manager configuration
rm -rf ${HOME}/.config/home-manager

# Clone this repo
REPO_URL=https://github.com/Caesarovich/42-nix-home-manager

mkdir -p ${HOME}/.config

git clone $REPO_URL "${HOME}/.config/home-manager"

# Install Gram editor (Zed fork, no AI/telemetry)
echo "Installing Gram editor via Homebrew..."
if command -v brew &>/dev/null; then
	brew install --cask gram
else
	echo "Homebrew not found, skipping Gram installation"
fi
