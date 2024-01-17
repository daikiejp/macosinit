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
zshrc_file="zshrc"
system_wallpapers_folder="$pictures_folder/Wallpapers"
wallpapers_folder="$macosinit_folder/wallpapers"
wallpapers_data="$wallpapers_folder/wallpapers.json"
homebrew_packages="$config_folder/homebrew.txt"
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

if [ -d "$macosinit_folder" ]; then
  abort "Folder '$macosinit_folder' already exists. Please delete before starting."
  exit 1
else
  mkdir "$macosinit_folder"
  msg "Folder '$macosinit_folder' has been created."

  mkdir "$ssh_folder"
  msg "Folder '$ssh_folder' has been created."

  mkdir "$gpg_folder"
  msg "Folder '$gpg_folder' has been created."

  mkdir "$config_folder"
  msg "Folder '$config_folder' has been created."
fi
copy_and_rename() {
  local src_dir=$1
  local dest_dir=$2
  for file in "$src_dir"/*; do
    if [[ -f $file ]]; then
      base_name=$(basename "$file")
      new_name="${base_name#.}"
      cp "$file" "$dest_dir/$new_name"
    fi
  done
}

if [ -d "$system_ssh_folder" ]; then
  copy_and_rename "$system_ssh_folder" "$ssh_folder"
  msg "SSH files have been copied to '$ssh_folder' and renamed." 
else
  warning "SSH directory does not exist, skipping..."
fi
if ! gpg --list-keys > /dev/null 2>&1; then
  warning "No GPG public keys found to export."
else
  gpg --export --armor > "$gpg_folder/public_keys.asc"
  #msg "Public keys exported to $gpg_folder/public_keys.asc"
fi

if ! gpg --list-secret-keys > /dev/null 2>&1; then
  warning "No GPG private keys found to export."
else
  gpg --export-secret-keys --armor > "$gpg_folder/private_keys.asc"
  #msg "Private keys exported to $gpg_folder/private_keys.asc"
fi

gpg --export-ownertrust > "$gpg_folder/ownertrust.txt"
#msg "Ownertrust exported to $gpg_folder/ownertrust.txt"

msg "GPG keys have been exported to '$gpg_folder'."