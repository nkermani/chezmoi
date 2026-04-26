# Nix (Linux 42 no-sudo - use nix-user-chroot)
if test (uname -s) = "Linux"
   and test ! -S /run/current-system/sw/bin/nix-daemon
   and test -x "$HOME/nix-user-chroot"
   set -gx nix_bin "$HOME/nix-user-chroot $HOME/.nix"
end