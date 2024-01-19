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

if command -v brew >/dev/null 2>&1; then
    installed_packages=$(brew list)

    for package in $installed_packages; do
        echo "Uninstalling $package..."
        brew uninstall --force "$package"
    done

    msg "All Homebrew packages have been uninstalled."

    echo "Uninstalling Homebrew..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

    sudo rm -rf /usr/local/Homebrew
    sudo rm -rf /opt/homebrew
    sudo rm -rf /usr/local/Caskroom
    sudo rm -rf /usr/local/Cellar
    sudo rm -rf /usr/local/bin/brew

    sed -i '' '/# Homebrew/d' ~/.bash_profile
    sed -i '' '/# Homebrew/d' ~/.zshrc
    sed -i '' '/export PATH=\/usr\/local\/bin:\$PATH/d' ~/.bash_profile
    sed -i '' '/export PATH=\/opt\/homebrew\/bin:\$PATH/d' ~/.zshrc

    msg "Homebrew and all its packages have been successfully uninstalled."
else
    warning "Homebrew is not installed on this system. Skipping..."
fi

