# dotfiles

NixOS + home-manager. niri / fish / kitty / waybar. One host: `genius`.

App configs stay in their own formats under `config/` and are symlinked, not
rewritten in Nix.

## Install

Assumes NixOS is already installed.

```sh
# the path matters — links.nix resolves against ~/.dotfiles
git clone https://github.com/aakwat/.dotfiles-nixos.git ~/.dotfiles

cp /etc/nixos/hardware-configuration.nix ~/.dotfiles/hosts/genius/
git -C ~/.dotfiles add hosts/genius/hardware-configuration.nix
```

A flake only sees git-tracked files, so the `git add` is required.

Clear anything already sitting where a symlink goes:

```sh
cd ~/.config && rm -rf niri waybar mako tofi kitty hypr gtk-3.0 gtk-4.0 \
  yazi zellij nvim starship.toml
```

Then:

```sh
sudo nixos-rebuild switch --flake ~/.dotfiles#genius
```

Afterwards: `passwd kwat`, then delete `initialPassword` from
`modules/system/users.nix` — it lands in the world-readable `/nix/store`.

## Git SSH

`modules/home/programs/git.nix` signs every commit, so the key must exist
first:

```sh
ssh-keygen -t ed25519 -f ~/.ssh/coffee
```

Add the public key to GitHub **twice** — once as an Authentication key, once
as a Signing key. Verify with `ssh -T git@github.com`.

## Daily

| command | does |
| --- | --- |
| `sudo nixos-rebuild switch --flake ~/.dotfiles#genius` | apply |
| `nixos-rebuild build --flake ~/.dotfiles#genius` | build only, changes nothing |
| `nixos-rebuild switch --rollback` | previous generation |
| `nix flake check` | evaluate without building |
| `nix flake update` | bump all inputs |
| `nix search nixpkgs <name>` | find a package |
| `nix shell nixpkgs#<name>` | run something without installing it |
| `audit-security [path]` | scan a repo: secrets, dependency CVEs, SAST |
| `force-clean-config` | delete ~/.config entries that block activation |
| `nix-collect-garbage -d` | reclaim disk (weekly GC is already on) |

A broken boot picks the previous generation from the boot menu. That is the
recovery path for everything here, sudo-rs included.

## Layout

```
flake.nix              inputs, one nixosConfiguration
hosts/genius/          bootloader, hostname, stateVersion, hardware
modules/system/        audio desktop locale network nix packages security
                       users virtualisation
modules/home/          packages links · shell/ · desktop/ · programs/
config/                raw app configs, symlinked into ~/.config
scripts/               helper scripts, symlinked into ~/.local/bin
wallpapers/            symlinked to ~/Pictures/Wallpapers
```

Packages are declared in exactly two files: `modules/system/packages.nix`
(system-wide) and `modules/home/packages.nix` (user).

`config/` is linked out-of-store, so editing a file there takes effect
immediately. Adding or removing a file needs a rebuild.

## Security

`modules/system/security.nix`: sudo-rs, locked boot command line,
DNS-over-TLS + DNSSEC, kernel sysctls, `protectKernelImage`, fwupd.

`/nix/store` is world-readable. Never inline a secret into a `.nix` file —
use sops-nix or agenix.

## Another host

Add `hosts/<name>/`, then a second entry under `nixosConfigurations` in
`flake.nix`. Everything in `modules/` is shared unchanged.
