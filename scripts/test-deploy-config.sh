#!/usr/bin/env bash
# User-file deployment smoke tests in a disposable home; never touches real HOME.
set -euo pipefail
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
home="$tmp/home"
mkdir -p "$home/.config/ghostty" "$home/.config/nvim"
printf 'local nvim\n' > "$home/.config/nvim/init.lua"
printf 'local Ghostty\n' > "$home/.config/ghostty/config.ghostty"
args=(--home "$home" --tool nvim --tool ghostty --ghostty-dest "$home/.config/ghostty/config.ghostty")
script="$root/scripts/deploy-config.sh"
preview=$("$script" "${args[@]}")
[[ $preview = *'Preview only. No files changed.'* ]]
[[ ! -L $home/.config/nvim/init.lua ]]
[[ $(< "$home/.config/nvim/init.lua") = 'local nvim' ]]
"$script" "${args[@]}" --apply > "$tmp/applied"
[[ -L $home/.config/nvim/init.lua && -L $home/.config/nvim/lazy-lock.json && -L $home/.config/ghostty/config.ghostty ]]
[[ $(readlink "$home/.config/ghostty/config.ghostty") = "$root/config/ghostty/config" ]]
[[ $("$script" "${args[@]}" --apply | grep -c '^keep ') -eq 3 ]]
for name in nvim/init.lua ghostty/config.ghostty; do
  dest="$home/.config/$name"
  backup=$(find "$(dirname "$dest")" -name "$(basename "$dest").pre-dev-setup-*" -print -quit)
  [[ -f $backup ]]
  rm "$dest"
  mv "$backup" "$dest"
done
[[ $(< "$home/.config/nvim/init.lua") = 'local nvim' ]]
[[ $(< "$home/.config/ghostty/config.ghostty") = 'local Ghostty' ]]
if "$script" --home "$home" --tool kitty --apply > "$tmp/fail" 2>&1; then echo 'Kitty unexpectedly accepted' >&2; exit 1; fi
if "$script" --home "$home" --tool tmux --apply > "$tmp/fail" 2>&1; then echo 'tmux unexpectedly accepted' >&2; exit 1; fi
mkdir -p "$tmp/bin"
printf '#!/bin/sh\necho Darwin\n' > "$tmp/bin/uname"
chmod +x "$tmp/bin/uname"
PATH="$tmp/bin:$PATH" "$script" --home "$home" --tool nvim > "$tmp/mac-preview"
[[ $(< "$home/.config/nvim/init.lua") = 'local nvim' ]]
printf 'Preview, backup, repeat apply, restore, unsupported selections and mocked macOS branch: passed\n'
