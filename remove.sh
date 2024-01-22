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

delete_vimrc() {
  read -p "Are you sure you want to delete vimrc configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  if [ -f "$HOME/.vimrc" ]; then
    rm -f "$HOME/.vimrc"
    msg ".vimrc configuration has been deleted."
  else
    warning ".vimrc file does not exist. Skipping..."
  fi

}

delete_vimrc

