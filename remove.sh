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

delete_ssh_keys() {
  read -p "Are you sure you want to delete all SSH keys and configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  if [ -d "$system_ssh_folder" ]; then
    rm -rf "$system_ssh_folder"/*
    echo "All SSH keys and configurations have been deleted."
  else
    echo "The .ssh directory does not exist. Skipping..."
  fi
}

delete_ssh_keys
#!/bin/bash

delete_gpg_keys() {
  read -p "Are you sure you want to delete all GPG keys? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  for key in $(gpg --list-secret-keys --with-colons | grep '^sec' | awk -F: '{print $5}'); do
    echo "Deleting secret key: $key"
    gpg --delete-secret-keys "$key"
  done

  for key in $(gpg --list-keys --with-colons | grep '^pub' | awk -F: '{print $5}'); do
    echo "Deleting public key: $key"
    gpg --delete-keys "$key"
  done

  msg "All GPG keys have been deleted."
}

delete_gpg_keys
#!/bin/bash

delete_gitconfig() {
  read -p "Are you sure you want to delete all gitconfig preferences configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  if [ -f "$HOME/.gitconfig" ]; then
    rm -f "$HOME/.gitconfig"
    msg ".gitconfig configuration has been deleted."
  else
    warning ".gitconfig file does not exist. Skipping..."
  fi

  if [ -d "$system_config_folder/git" ]; then
    rm -rf "$system_config_folder/git"
    msg "All gitconfig configurations have been deleted."
  else
    warning "The $system_config_folder/git directory does not exist. Skipping..."
  fi
}

delete_gitconfig
