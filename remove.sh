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

delete_zshrc() {
  read -p "Are you sure you want to delete .zshrc configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  if [ -f "$HOME/.zshrc" ]; then
    rm -f "$HOME/.zshrc"
    msg ".zshrc configuration has been deleted."
  else
    warning ".zshrc file does not exist. Skipping..."
  fi
}

delete_zshrc
#!/bin/bash

delete_ohmyzshpower10k() {
  read -p "Are you sure you want to delete Oh My Zsh and Power10k. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  if [ -d "$HOME/.oh-my-zsh/" ]; then
    rm -rf "$HOME/.oh-my-zsh"/*

    msg "All Oh My Zsh and Power10k configurations have been deleted."
  else
    warning "The Oh My Zsh does not exist. Skipping..."
  fi

  rm -f "$HOME/.zshrc"*
  rm -f "$HOME/.zshrc.pre-oh-my-zsh"*
  msg "All zshrc configurations have been deleted."

  rm -f "$HOME/.zsh_history"*

  rm -f "$HOME/.zcompdump"*

  rm -rf "$HOME/.zsh_sessions"

  rm -f "$HOME/.zprofile"*
  rm -f "$HOME/.profile"*
}

delete_ohmyzshpower10k
#!/bin/bash

delete_wakatime() {
  read -p "Are you sure you want to delete wakatime configurations? This action cannot be undone. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  if [ -f "$HOME/.wakatime.cfg" ]; then
    rm -f "$HOME/.wakatime.cfg"
    msg ".wakatime.cfg configuration has been deleted."
  else
    warning ".wakatime.cfg file does not exist. Skipping..."
  fi

  if [ -d "$HOME/.wakatime" ]; then
    rm -rf "$HOME/.wakatime"
    rm -rf $HOME/.wakatime*
    msg "All wakatime folder and configurations have been deleted."
  else
    warning "The $HOME/.wakatime directory does not exist. Skipping..."
  fi
}

delete_wakatime
