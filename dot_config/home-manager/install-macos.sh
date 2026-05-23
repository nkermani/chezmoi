NIX_BIN="/nix/var/nix/profiles/default/bin"

if [ -f "${NIX_BIN}/nix-channel" ]; then
	echo "Nix is already installed, skipping"
else
	curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
	bash /tmp/nix-install.sh
	rm /tmp/nix-install.sh
fi

export PATH="${NIX_BIN}:${PATH}"

echo "Enabling Nix daemon..." 
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist 2>/dev/null || true # Enable Nix daemon for single-user mode
sleep 2 # Wait for daemon to start
echo "Setting up PATH for bash" # Setup bash PATH

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

if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix.sh" ]; then
	. "/nix/var/nix/profiles/default/etc/profile.d/nix.sh" # Source nix.sh for current session
fi

echo "Enabling home-manager for the current user"
${NIX_BIN}/nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
${NIX_BIN}/nix-channel --add https://nixos.org/channels/nixos-unstable unstable
${NIX_BIN}/nix-channel --update
${NIX_BIN}/nix-shell '<home-manager>' -A install

rm -rf ${HOME}/.config/home-manager # Remove base home-manager configuration
chezmoi apply && home-manager switch # Apply chezmoi to put my own home-manager config
