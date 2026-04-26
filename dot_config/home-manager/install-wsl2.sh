# dot_config/home-manager/install-wsl2.sh

NIX_PROFILE="${HOME}/.nix-profile"
NIX_BIN="${NIX_PROFILE}/bin"

if [ -f "${NIX_BIN}/nix-channel" ]; then
	echo "Nix is already installed, skipping"
else
	echo "Installing Nix for WSL2..."
	curl -L https://nixos.org/nix/install -o /tmp/nix-install.sh
	bash /tmp/nix-install.sh
	rm /tmp/nix-install.sh
fi

export PATH="${NIX_BIN}:${PATH}"

# Enable home-manager
echo "Enabling home-manager for the current user"

${NIX_BIN}/nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
${NIX_BIN}/nix-channel --update
${NIX_BIN}/nix-shell '<home-manager>' -A install