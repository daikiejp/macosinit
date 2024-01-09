#Install ssh into the system.
if [ -d "$ssh_folder" ]; then
  cp -r "$ssh_folder" ~/.ssh
  msg "Copied all ssh files into the system."
else
  abort "Error: The 'ssh' folder does not exist at the specified location."
fi

