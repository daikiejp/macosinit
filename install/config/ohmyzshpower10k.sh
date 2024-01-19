#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install Oh My Zsh
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

# Install Powerlevel10k
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

# Check if Homebrew is installed
# if ! command_exists brew; then
#     warning "Homebrew is not installed. Installing Homebrew..."
#     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# else
#     msg "Homebrew is already installed."
# fi

# Install Oh My Zsh and Powerlevel10k
install_oh_my_zsh
install_powerlevel10k

# Apply the changes
# echo "Applying changes..."
# source ~/.zshrc

echo "Installation completed. Please restart your terminal."
