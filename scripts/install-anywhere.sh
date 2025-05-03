#!/usr/bin/env nix-shell
#! nix-shell -i bash
#! nix-shell -p bash nixos-anywhere

temp=$(mktemp -d)
nixdir="/home/colin/.config/new-nix-config"

cleanup() {
	rm -rf "$temp"
}

install -d -m755 "$temp/root/.ssh/"
cat /home/colin/.ssh/id_ed25519.pub >> "$temp/root/.ssh/authorized_keys"

chmod 600 "$temp/root/.ssh/authorized_keys"

nixos-anywhere --extra-files "$temp" --flake "$nixdir#pliny" --generate-hardware-config nixos-generate-config "$nixdir/hosts/pliny/hardware-config.nix" root@192.168.1.107
