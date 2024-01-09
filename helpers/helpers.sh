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

# Folders
desktop_path="$HOME/Desktop"
system_ssh_folder="$HOME/.ssh"
macosinit_folder="$desktop_path/macosinit"
ssh_folder="$macosinit_folder/ssh/"
gpg_folder="$macosinit_folder/gpg"
config_folder="$macosinit_folder/config"
