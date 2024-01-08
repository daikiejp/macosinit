msg() {
  local message=$1
  echo -e "✅ \033[0;32m${message}\033[0m"
}

abort() {
  printf "❌ \033[0;31m%s\n\033[0m" "$@" >&2
  exit 1
}

