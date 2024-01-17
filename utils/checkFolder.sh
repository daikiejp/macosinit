#!/bin/bash

# Check if the folder exists
if [ -d "$macosinit_folder" ]; then
  abort "Folder '$macosinit_folder' already exists. Please delete before starting."
  exit 1
else
  # Create the folder if it doesn't exist
  mkdir "$macosinit_folder"
  msg "Folder '$macosinit_folder' has been created."

  # Create SSH Folder
  mkdir "$ssh_folder"
  msg "Folder '$ssh_folder' has been created."
fi