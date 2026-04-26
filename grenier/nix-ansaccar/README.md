# Nix home manager config for 42 school

## Installation

The script installs the nix-chroot environment and enables home-manager.
```sh
wget -O- https://raw.githubusercontent.com/Caesarovich/42-nix-home-manager/refs/heads/main/install.sh | sh
```

Then enter the nix environment and run the following command to install home-manager configuration:
```sh
./nix-user-chroot ~/.nix
home-manager switch
```

## Usage

To enter the nix environment, run the following command:
```sh
./nix-user-chroot ~/.nix
```

To update the home-manager configuration, run the following command:
```sh
home-manager switch
```

To update the packages, run the following command:
```sh
nix-channel --update
home-manager switch
```