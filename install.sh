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

if command -v xcode-select >/dev/null 2>&1; then
    msg "Xcode Command Line Tools is already installed."
else
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
fi

find $macosinit_folder -name '.DS_Store' -type f -delete

if [ -d "$macosinit_folder" ]; then
  msg "The 'macosinit' folder exists on the desktop."
else
  abort "Error: The 'macosinit' folder does not exist on the desktop."
fi

if [ -d "$ssh_folder" ]; then
  msg "The 'ssh' folder exists on the desktop."
else
  abort "Error: The 'ssh' folder does not exist on the 'macosinit' folder."
fi

if [ -d "$gpg_folder" ]; then
  msg "The 'gpg' folder exists on the desktop."
else
  abort "Error: The 'gpg' folder does not exist on the 'macosinit' folder."
fi

if [ -d "$config_folder" ]; then
  msg "The 'config' folder exists on the desktop."
else
  abort "Error: The 'config' folder does not exist on the 'macosinit' folder."
fi

#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_oh_my_zsh() {
    if command_exists zsh; then
        msg "Zsh is already installed."
    else
        brew install zsh || { abort "Failed to install Zsh"; }
    fi

    if [ -d "$HOME/.oh-my-zsh" ]; then
        msg "Oh My Zsh is already installed."
    else
        RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || { abort "Failed to install Oh My Zsh"; }
    fi
}

install_powerlevel10k() {
    if [ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
        msg "Powerlevel10k is already installed."
    else
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k || { abort "Failed to install Power10k"; }
          if [[ -f "$HOME/.zshrc" ]]; then
            sed -i.bak 's|ZSH_THEME="robbyrussell"|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc"
            msg "Theme powerlevel10k replaced successfully."
            rm -f "$HOME/.zshrc.bak"
          else
            warning "Powerlevel10k is not installed"
          fi
    fi
}


install_oh_my_zsh
install_powerlevel10k
#!/bin/bash

comment_line='# GPG Issue'
line_to_add='export GPG_TTY=$TTY'

zshrc_file="$HOME/.zshrc"

if [ ! -f "$zshrc_file" ]; then
  touch "$zshrc_file"
  msg "Created $zshrc_file as it did not exist."
fi

if grep -Fxq "$comment_line" "$zshrc_file" && grep -Fxq "$line_to_add" "$zshrc_file"; then

  warning "The line '$line_to_add' already exists in $zshrc_file. No changes made."
else
  {
    echo "$comment_line"
    echo "$line_to_add"
    echo ""
    cat "$zshrc_file"
  } > "$zshrc_file.tmp" && mv "$zshrc_file.tmp" "$zshrc_file"

  msg ".zshrc file is created and added GPG_TTY"
fi
#!/bin/bash

if [ -f "$config_folder/wakatime.cfg" ]; then
  cp "$config_folder/wakatime.cfg" "$HOME/.wakatime.cfg"
  msg "The wakatime.cfg file has been copied."
else
  warning "The wakatime config file does not exist in the $config_folder directory. Skipping..."
fi