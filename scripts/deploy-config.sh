#!/usr/bin/env bash
# User-level file deployment only. Preview is the default; --apply requires prior approval.
set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
target_home=${HOME:?HOME is required}
mode=preview
ghostty_dest=
tools=()
usage() {
  printf 'Usage: %s [--home DIR] --tool nvim|ghostty [--tool ...] [--ghostty-dest PATH] [--apply]\n' "$0" >&2
  exit 2
}
while (($#)); do
  case $1 in
    --home) (($# >= 2)) || usage; target_home=$2; shift 2 ;;
    --tool) (($# >= 2)) || usage; tools+=("$2"); shift 2 ;;
    --ghostty-dest) (($# >= 2)) || usage; ghostty_dest=$2; shift 2 ;;
    --apply) mode=apply; shift ;;
    *) usage ;;
  esac
done
((${#tools[@]})) || usage
case $(uname -s) in
  Darwin) platform=macos ;;
  Linux)
    [[ -f /etc/os-release ]] && . /etc/os-release
    [[ ${ID:-} = arch || " ${ID_LIKE:-} " = *' arch '* ]] || {
      echo 'Only Arch Linux and macOS are supported.' >&2; exit 2;
    }
    platform=arch ;;
  *) echo 'Only Arch Linux and macOS are supported.' >&2; exit 2 ;;
esac
[[ -d $target_home ]] || { echo "Home directory does not exist: $target_home" >&2; exit 2; }
target_home=$(cd "$target_home" && pwd -P)

sources=() destinations=()
add() { sources+=("$root/$1"); destinations+=("$target_home/$2"); }
for tool in "${tools[@]}"; do
  case $tool in
    nvim) add config/nvim/init.lua .config/nvim/init.lua
          add config/nvim/lazy-lock.json .config/nvim/lazy-lock.json ;;
    ghostty)
      [[ -n $ghostty_dest ]] || { echo 'Ghostty needs --ghostty-dest: inspect all active config paths first.' >&2; exit 2; }
      [[ $ghostty_dest = "$target_home/"* && $ghostty_dest != */ && $ghostty_dest != *'/../'* && $ghostty_dest != *'/./'* && $ghostty_dest != *'//'* ]] || { echo 'Ghostty destination must be a direct path under --home without traversal.' >&2; exit 2; }
      sources+=("$root/config/ghostty/config"); destinations+=("$ghostty_dest") ;;
    *) echo "Unknown tool: $tool" >&2; usage ;;
  esac
done

# Complete read-only preflight before touching any destination.
for ((i=0; i<${#sources[@]}; i++)); do
  src=${sources[i]} dst=${destinations[i]}
  [[ -f $src ]] || { echo "Missing source: $src" >&2; exit 1; }
  for ((j=0; j<i; j++)); do
    [[ $dst != "${destinations[j]}" ]] || { echo "Duplicate destination: $dst" >&2; exit 2; }
  done
  [[ ! -d $dst || -L $dst ]] || { echo "Directory at destination: $dst" >&2; exit 1; }
  parent=$(dirname "$dst")
  while [[ $parent != "$target_home" ]]; do
    [[ $parent = "$target_home/"* && ! -L $parent && ( ! -e $parent || -d $parent ) ]] || {
      echo "Unsafe parent (not a real directory under home): $parent" >&2; exit 1;
    }
    parent=$(dirname "$parent")
  done
  if [[ -L $dst && $(readlink "$dst") = "$src" ]]; then
    printf 'keep   %s -> %s\n' "$dst" "$src"
  elif [[ -e $dst || -L $dst ]]; then
    printf 'backup %s; link -> %s\n' "$dst" "$src"
  else
    printf 'link   %s -> %s\n' "$dst" "$src"
  fi
done
[[ $mode = apply ]] || { echo 'Preview only. No files changed.'; exit 0; }

stamp=$(date +%Y%m%d%H%M%S)-$$
for ((i=0; i<${#sources[@]}; i++)); do
  src=${sources[i]} dst=${destinations[i]}
  if [[ -L $dst && $(readlink "$dst") = "$src" ]]; then continue; fi
  mkdir -p "$(dirname "$dst")"
  if [[ -e $dst || -L $dst ]]; then
    backup="$dst.pre-dev-setup-$stamp"
    [[ ! -e $backup && ! -L $backup ]] || { echo "Backup collision: $backup" >&2; exit 1; }
    mv "$dst" "$backup"
    printf 'Saved existing file: %s\n' "$backup"
  fi
  ln -s "$src" "$dst"
  printf 'Linked: %s -> %s\n' "$dst" "$src"
done
printf 'Verify the application before removing backups. To restore: remove each new link and move its saved .pre-dev-setup-* file back.\n'
