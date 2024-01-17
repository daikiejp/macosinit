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


if [ -z "$(ls -A $ssh_folder)" ]; then
    warning "No SSH keys found in $ssh_folder"
else
    mkdir -p "$system_ssh_folder"

    for ssh_key_file in $ssh_folder/*; do
        chmod 600 "$ssh_key_file"

        ssh_public_key=$(ssh-keygen -y -f $ssh_key_file 2>&1)

        if [[ $ssh_public_key == *"invalid format"* ]]; then
            cp "$ssh_key_file" "$system_ssh_folder"
            msg "SSH keys from $ssh_key_file copied to $system_ssh_folder"

        else
            cp "$ssh_key_file" "$system_ssh_folder"

            msg "SSH keys from $ssh_key_file copied to $system_ssh_folder"
        fi 
    done
fi


if [ -z "$(ls -A $config_folder/ssh/config)" ]; then
    warning "No SSH config found in $ssh_folder. Skipping..."
else
    cp "$config_folder/ssh/config" "$system_ssh_folder/config"
    msg "The SSH config file has been copied."
fi

