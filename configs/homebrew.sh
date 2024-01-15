# Check if Homebrew is installed
if command -v brew &> /dev/null; then
    msg "Homebrew is already installed."
else
    # Install Homebrew if not installed
    warning "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    (echo "# Set PATH, MANPATH, etc., for Homebrew."; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Check if the external file exists
if [ ! -f $homebrew_packages ]; then
    warning "No Homebrew packages file found."
else
    # Read packages from the external file and install them
    while IFS= read -r package; do
        # Skip comments and empty lines
        [[ "$package" =~ ^\ *# ]] || [ -z "$package" ] && continue

        warning "Installing $package..."
        brew install "$package"
    done < $homebrew_packages

    msg "Homebrew packages installation complete."
fi

