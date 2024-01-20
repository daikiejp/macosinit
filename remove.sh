echo -e "====================="
echo -e "Welcome to macOS Init"
echo -e "=====================\n"

msg() {
  local message=$1
  echo -e "✅ \033[0;32m${message}\033[0m"
}

warning() {
  local message=$1
  echo -e "📢 \033[38;5;208m${message}\033[0m"
}

abort() {
  printf "❌ \033[0;31m%s\n\033[0m" "$@" >&2
  exit 1
}

desktop_path="$HOME/Desktop"
system_ssh_folder="$HOME/.ssh"
pictures_folder="$HOME/Pictures"
macosinit_folder="$desktop_path/macosinit"
ssh_folder="$macosinit_folder/ssh"
gpg_folder="$macosinit_folder/gpg"
config_folder="$macosinit_folder/config"
zshrc_file="$HOME/.zshrc"
system_wallpapers_folder="$pictures_folder/Wallpapers"
wallpapers_folder="$macosinit_folder/wallpapers"
homebrew_packages="$config_folder/brew.txt"
scripts_folder="$macosinit_folder/scripts"
system_scripts="$HOME/.config/scripts"
system_config_folder="$HOME/.config"
aliases_file="$macosinit_folder/aliases.sh"
aliases_system_file="$system_config_folder/aliases.sh"

OS="$(uname)"
if [[ "${OS}" == "Darwin" ]]
then
  msg "macOS detected."
else
  abort "macOS Init is only supported on macOS."
fi

#!/bin/bash

delete_wallpaper() {
  read -p "Are you sure you want to delete all Wallpapers? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  if [ -d "$system_wallpapers_folder" ]; then
    rm -rf "$system_wallpapers_folder"/*
    echo "All Wallpapers have been deleted."
  else
    echo "The Wallpaper directory does not exist. Skipping..."
  fi
}

delete_wallpaper

