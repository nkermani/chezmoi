ARCH=$(uname -m)

NIX_CHROOT_DOWNLOAD_URL=https://github.com/nix-community/nix-user-chroot/releases/download/2.1.1/nix-user-chroot-bin-2.1.1-${ARCH}-unknown-linux-musl

echo "Downloading nix-user-chroot from $NIX_CHROOT_DOWNLOAD_URL"
INSTALL_PATH="${HOME}/nix-user-chroot"
curl -L "$NIX_CHROOT_DOWNLOAD_URL" -o ${INSTALL_PATH}

echo "Setting up PATH for bash"
if ! grep -q 'nix.sh' "${HOME}/.bash_profile"; then # Check if the line is already in .bash_profile to avoid duplicates
echo "Adding nix.sh to .bash_profile"

cat >> "${HOME}/.bash_profile" <<'EOF'
if [ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
	. "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi
EOF

else
	echo "nix.sh is already in .bash_profile, skipping"
fi

chmod +x ${INSTALL_PATH} 
NIX_FOLDER="${HOME}/.nix"
mkdir -m 0755 ${NIX_FOLDER}
${INSTALL_PATH} ${NIX_FOLDER} bash -c "curl -L https://nixos.org/nix/install | bash" # Installing the nix environment
echo "Installation complete. You can run nix-user-chroot with ${INSTALL_PATH}"

echo "Enabling home-manager for the current user"
${INSTALL_PATH} ${NIX_FOLDER} ${HOME}/.nix-profile/bin/nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
${INSTALL_PATH} ${NIX_FOLDER} ${HOME}/.nix-profile/bin/nix-channel --add https://nixos.org/channels/nixos-unstable unstable
${INSTALL_PATH} ${NIX_FOLDER} ${HOME}/.nix-profile/bin/nix-channel --update
${INSTALL_PATH} ${NIX_FOLDER} ${HOME}/.nix-profile/bin/nix-shell '<home-manager>' -A install

rm -rf ${HOME}/.config/home-manager # Remove base home-manager configuration
chezmoi apply && home-manager switch # Apply chezmoi to put my own home-manager config