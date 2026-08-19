# TODO — run these on the NixOS machine

In order. Each step says what you should see.

## 1. Pull and rebuild

```sh
git -C ~/.dotfiles pull
bash ~/.dotfiles/scripts/force-clean-config.sh
sudo nixos-rebuild switch --flake ~/.dotfiles#genius
exec fish
```

`force-clean-config` deletes real files where symlinks belong. It prints
existing links and never touches them. Run it by path the first time — it only
reaches `~/.local/bin` after a successful activation.

Watch the rebuild for `Existing file ... would be clobbered`. That kills the
whole home-manager generation, which is why one stray directory can cost every
user package at once.

## 2. Did the user profile activate?

```sh
ls /etc/profiles/per-user/kwat/bin | wc -l
```

Should be a few dozen. If it is 0 or missing, nothing below will work — go
back to step 1 and read the activation error.

```sh
for c in waybar mako tofi cliphist hypridle hyprlock brightnessctl playerctl \
         cava swappy awww nm-applet impala bluetuith zellij yazi fd eza bat; do
  command -v $c >/dev/null || echo "MISSING: $c"
done
```

Anything printed goes into `modules/home/packages.nix`.

## 3. SSH key — do this before any commit

`commit.gpgSign = true`, so commits fail until the key exists.

```sh
ssh-keygen -t ed25519 -f ~/.ssh/coffee
cat ~/.ssh/coffee.pub
```

Add that key to GitHub **twice**: once as an Authentication key, once as a
Signing key. Then:

```sh
ssh -T git@github.com          # expect: Hi aakwat! ... does not provide shell access
git -C ~/.dotfiles commit --allow-empty -m signing-test && \
git -C ~/.dotfiles log --show-signature -1
```

## 4. Wallpaper

```sh
rm -f ~/.local/state/wallpaper   # a saved choice outranks the default
wallpaper
```

A saved state wins over `DEFAULT`, so clear it once to pick up
`wallhaven-2e2xyx.jpg`.

## 5. Check the desktop pieces

```sh
loginctl lock-session      # hyprlock must let you back in (PAM)
resolvectl status          # with WARP connected — see which DNS wins
```

- Ctrl+Space toggles the Myanmar (`mm`) keyboard layout
- Mod+Space opens tofi, Mod+Return kitty, Mod+B librewolf
- waybar: click wifi for `impala`, bluetooth for `bluetuith`

## 6. Clean up the old setup

```sh
sudo mv /etc/nixos /etc/nixos.bak    # unused once the flake is in charge
sudo nix-collect-garbage -d
```

## Still open

- **No disk encryption.** LUKS is install-time only, so a reinstall is the
  only way to add it. Biggest remaining gap for a laptop.
- **Secrets**: sops-nix or agenix before the first one. Never inline —
  `/nix/store` is world-readable.
- **`config/fish/` not mirrored** from Arch: no abbrs, no sdkman/fnm PATH.
  Decide what is still wanted here.
- **`backupFileExtension = "hm-bak"`** in `flake.nix` silently renames
  colliding files. With `force-clean-config` around, failing loudly may be
  better.
