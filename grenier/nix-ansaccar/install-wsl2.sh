# NK-nix-home-manager/install-wsl2.sh

NIX_BIN="/nix/var/nix/profiles/default/bin"

if [ -f "${NIX_BIN}/nix-channel" ]; then
	echo "Nix is already installed, skipping"
else
	echo "Installing Nix for WSL2..."
	curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
	bash /tmp/nix-install.sh
	rm /tmp/nix-install.sh
fi

export PATH="${NIX_BIN}:${PATH}"

echo "Setting up PATH for bash"

if ! grep -q 'nix.sh' "${HOME}/.bashrc"; then
	echo "Adding nix.sh to .bashrc"

	cat >>"${HOME}/.bashrc" <<'EOF'
if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix.sh" ]; then
    . "/nix/var/nix/profiles/default/etc/profile.d/nix.sh"
fi
EOF
else
	echo "nix.sh is already in .bashrc, skipping"
fi

# Source nix.sh for current session
if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix.sh" ]; then
	. "/nix/var/nix/profiles/default/etc/profile.d/nix.sh"
fi

# Enable home-manager
echo "Enabling home-manager for the current user"
${NIX_BIN}/nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
${NIX_BIN}/nix-channel --update
${NIX_BIN}/nix-shell '<home-manager>' -A install