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
ssh_folder="$macosinit_folder/ssh/"
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

if command -v brew &> /dev/null; then
    msg "Homebrew is already installed."
else
    warning "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo "# Set PATH, MANPATH, etc., for Homebrew."; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ ! -f $homebrew_packages ]; then
    warning "No Homebrew packages file found."
else
    while IFS= read -r package; do
        [[ "$package" =~ ^\ *# ]] || [ -z "$package" ] && continue

        warning "Installing $package..."
        brew install "$package"
    done < $homebrew_packages

    msg "Homebrew packages installation complete."
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

if [ -z "$(ls -A $wallpapers_folder)" ]; then
    warning "Wallpapers JSON file not found in $wallpapers_folder"
else
    mkdir -p $system_wallpapers_folder

    for category in $(cat "$wallpapers_data" | sed -n 's/"\([^"]*\)": \[.*/\1/p'); do
        warning "Downloading Wallpapers for: $category"
        mkdir -p "$system_wallpapers_folder/$category"
        
        for url in $(cat "$wallpapers_data" | sed -n "/$category\": \[/,/]/p" | sed -e 's/^[[:space:]]*//' -e 's/"//g' -e 's/,//'); do
            curl -s "$url" -o "$system_wallpapers_folder/$category/$(basename "$url")"
        done
        msg "Downloaded all images into Wallpaper/$category folder"
    done
fi


if [ -z "$(ls -A $config_folder/$zshrc_file)" ]; then
    abort "No zshrc file was found in $zshrc_file"
else
    cp "$config_folder/$zshrc_file" "$HOME" && mv "$HOME/$zshrc_file" "$HOME/.$zshrc_file"
    msg "zshrc from "$config_folder/$zshrc_file" copied to $HOME"
fi


if [ -z "$(ls -A $scripts_folder)" ]; then
    warning "No scripts found in $scripts_folder"
else
    if [ -z "$(ls -A $aliases_file)" ]; then
        warning "No aliases found in $scripts_folder"
    else
        cp "$aliases_file" "$system_config_folder"

        mkdir -p "$system_scripts"

        for scripts_file in $scripts_folder/*; do

        cp "$scripts_file" "$system_scripts"

        msg "Scripts from $scripts_file copied to $system_scripts" 
        done
        
        if [[ -f "$aliases_system_file" ]]; then
            sed -i '' 's|SCRIPT_DIR="scripts"|SCRIPT_DIR="$HOME/.config/scripts"|' "$aliases_system_file"
            msg "The line SCRIPT_DIR has been successfully replaced in $aliases_system_file."
        else
            warning "The file $aliases_system_file does not exist."
        fi

        chmod +x "$aliases_system_file"

        /bin/bash -c "$aliases_system_file"
    fi
fi