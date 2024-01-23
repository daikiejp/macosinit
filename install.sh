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

if [[ ! -f "$homebrew_packages" ]]; then
    warning "Error: File '$homebrew_packages' not found."
fi

if ! command -v brew >/dev/null 2>&1; then
    echo "Installing Homebrew..."



    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source ~/.zprofile

    if command -v brew >/dev/null 2>&1; then
        msg "Homebrew installed successfully."
    else
        abort "Failed to install Homebrew."
    fi
else
    warning "Homebrew is already installed. Skipping..."
fi

echo "Updating Homebrew..."
brew update

xargs brew install < $homebrew_packages

msg "All packages from $homebrew_packages have been processed."


if [ -z "$(ls -A $ssh_folder)" ]; then
    warning "No SSH keys found in $ssh_folder"
else
    mkdir -p "$system_ssh_folder"

    for ssh_key_file in $ssh_folder/*; do
        chmod 600 "$ssh_key_file"



            cp "$ssh_key_file" "$system_ssh_folder"
            msg "SSH keys from $ssh_key_file copied to $system_ssh_folder"

            msg "SSH keys from $ssh_key_file copied to $system_ssh_folder"
    done
fi


for key_file in "$gpg_folder"/*.asc; do
    if [ -e "$key_file" ]; then
        key_id=$(gpg --with-colons --import-options show-only --import "$key_file" 2>/dev/null | awk -F: '$1=="pub"{print $5}')
        
        if gpg --list-keys "$key_id" &> /dev/null; then
            warning "Key $key_id is already installed."
        else
            gpg --import "$key_file" &>/dev/null
            import_exit_code=$?

            if [ $import_exit_code -eq 0 ]; then
                msg "Key $key_id has been successfully imported."
                
            else
                abort "Error: Failed to import key from $key_file."
            fi
        fi
    else
        warning "No GPG key files found in the specified folder."
    fi
done


if [ -z "$(ls -A $config_folder/ssh/config)" ]; then
    warning "No SSH config found in $ssh_folder. Skipping..."
else
    cp "$config_folder/ssh/config" "$system_ssh_folder/config"
    msg "The SSH config file has been copied."
fi

#!/bin/bash

if [ -f "$config_folder/git/gitconfig" ]; then
  cp "$config_folder/git/gitconfig" "$HOME/.gitconfig"
  msg "The .gitconfig file has been copied."
else
  warning "The .gitconfig file does not exist in the $config_folder directory. Skipping..."
fi

copy_git_configs() {
  local src_dir=$1
  local dest_dir=$2
  mkdir -p "$dest_dir"
  for file in "$src_dir"/*; do
    base_name=$(basename "$file")
    if [[ -f $file && "$base_name" != "gitconfig" ]]; then
      cp "$file" "$dest_dir"
    fi
  done
}

if [ -d "$config_folder/git" ]; then
  mkdir -p "$config_folder/git"
  copy_git_configs "$config_folder/git" "$system_config_folder/git"
  msg "The git config files have been copied, excluding gitconfig."
else
  warning "The git config directory does not exist in the $config_folder directory. Skipping..."
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

#!/bin/bash

if [ -f "$config_folder/vimrc" ]; then
  cp "$config_folder/vimrc" "$HOME/.vimrc"
  msg "The vimrc file has been copied."
else
  warning "The vimrc config file does not exist in the $config_folder directory. Skipping..."
fi

if [ -z "$(ls -A $wallpapers_folder)" ]; then
    warning "Wallpapers JSON file not found in $wallpapers_folder. Skipping..."
else
    mkdir -p $system_wallpapers_folder

    cp -r "$wallpapers_folder"/* "$system_wallpapers_folder"
    msg "Wallpapers installed."
fi

if [ -z "$(ls -A $fonts_folder)" ]; then
    warning "fonts JSON file not found in $fonts_folder. Skipping..."
else
    mkdir -p $system_fonts_folder

    cp -r "$fonts_folder"/* "$system_fonts_folder"
    msg "Fonts installed."
fi

