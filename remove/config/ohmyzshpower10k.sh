#!/bin/bash

# Function to delete all Oh My Zsh and Power10k configurations
delete_ohmyzshpower10k() {
  # Confirm the deletion
  read -p "Are you sure you want to delete Oh My Zsh and Power10k. (y/n): " confirmation

  if [ "$confirmation" != "y" ]; then
    warning "Aborted."
    return 1
  fi

  # Check if the .oh-my-zsh directory exists
  if [ -d "$HOME/.oh-my-zsh/" ]; then
    # Delete all contents of the .oh-my-zsh/ directory
    rm -rf "$HOME/.oh-my-zsh"/*

    msg "All Oh My Zsh and Power10k configurations have been deleted."
  else
    warning "The Oh My Zsh does not exist. Skipping..."
  fi

  # Delete all files starts with .zshrc
  rm -f "$HOME/.zshrc"*
  rm -f "$HOME/.zshrc.pre-oh-my-zsh"*
  msg "All zshrc configurations have been deleted."

  # Delete all zsh History
  rm -f "$HOME/.zsh_history"*

  # Delete all zsh autocomplete
  rm -f "$HOME/.zcompdump"*

  # Delete all zsh sessions
  rm -rf "$HOME/.zsh_sessions"

  # Delete Zprofile
  rm -f "$HOME/.zprofile"*
  rm -f "$HOME/.profile"*
}

# Call the function
delete_ohmyzshpower10k
