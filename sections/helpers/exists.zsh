# Check if the command exists and return it.
exists() {
  command -v "$1" >/dev/null 2>&1
}
