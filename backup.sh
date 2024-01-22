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
system_config_folder="$HOME/.config"
fonts_folder="$macosinit_folder/fonts"
system_fonts_folder="$HOME/Library/Fonts"

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
      if [[ "$base_name" != "config" ]]; then
        new_name="${base_name#.}"
        cp "$file" "$dest_dir/$new_name"
      fi
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

if [ -f "$system_ssh_folder/config" ]; then
  mkdir -p "$config_folder/ssh"
  cp "$system_ssh_folder/config" "$config_folder/ssh/config"
  msg "The config file has been copied to the Desktop."
else
  warning "The SSH config file does not exist in the .ssh directory."
fi
if command -v brew >/dev/null 2>&1; then
    brew leaves -r > "$homebrew_packages"
    brew list --cask >> "$homebrew_packages"

    msg "List of installed Homebrew packages has been successfully exported to $homebrew_packages"
else
    warning "Homebrew is not installed on this system. Skipping..."
    touch $homebrew_packages
fi

if [ -f "$HOME/.gitconfig" ]; then
  mkdir -p "$config_folder/git"
  cp "$HOME/.gitconfig" "$config_folder/git/gitconfig"
  msg "The .gitconfig file has been copied. (It's not hidden)"
else
  warning "The .gitconfig file does not exist in the $HOME directory. Skipping..."
fi

if [ -d "$system_config_folder/git" ]; then
  cp -R "$system_config_folder/git" "$config_folder"
  msg "The git config files has been copied."
else
  warning "The git config files does not exists in the $config_folder directory. Skipping..."
fi

if [ -f "$HOME/.wakatime.cfg" ]; then
  cp "$HOME/.wakatime.cfg" "$config_folder/wakatime.cfg"
  msg "The wakatime.cfg file has been copied. (It's not hidden)"
else
  warning "The wakatime config file does not exist in the $HOME directory. Skipping..."
fi

if [ -f "$HOME/.vimrc" ]; then
  cp "$HOME/.vimrc" "$config_folder/vimrc"
  msg "The vimrc file has been copied. (It's not hidden)"
else
  warning "The vimrc config file does not exist in the $HOME directory. Skipping..."
fi

if [ -d "$system_wallpapers_folder" ]; then
  mkdir -p "$wallpapers_folder"
  cp -r "$system_wallpapers_folder"/* "$wallpapers_folder"
  msg "Wallpapers have been copied to '$wallpapers_folder'." 
else
  warning "Wallpaper directory does not exist, skipping..."
fi

if [ -d "$system_fonts_folder" ]; then
  mkdir -p "$fonts_folder"
  cp -r "$system_fonts_folder"/* "$fonts_folder"
  msg "Fonts have been copied to '$fonts_folder'." 
else
  warning "Fonts directory does not exist, skipping..."
fi
