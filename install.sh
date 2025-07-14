#!/bin/bash

# A script to create symbolic links in /usr/local/bin for specified files.

set -e # Exit immediately if a command exits with a non-zero status.

# --- Default values ---
FORCE=false
TARGET_DIR="/usr/local/bin"
FILES=()

# --- Helper Functions ---

# Display help information and exit with a specific code.
usage() {
  cat <<EOF
Usage: $(basename "$0") [options] <file1> [file2] ...

Creates symbolic links for specified files in ${TARGET_DIR}.

Options:
  -f, --force   Force overwrite if a symbolic link with the same name already exists.
  -h, --help    Display this help message and exit.

Examples:
  # Install a single file
  $(basename "$0") my_script.sh

  # Install multiple files using a glob pattern
  $(basename "$0") *.py

  # Force install, overwriting existing links
  $(basename "$0") -f *.py
EOF
  # Exit with the provided status code, or 0 if not specified.
  exit "${1:-0}"
}

# --- Argument Parsing ---

while (( "$#" )); do
  case "$1" in
    -f|--force)
      FORCE=true
      shift
      ;;
    -h|--help)
      usage 0
      ;;
    -*) # Handle unsupported flags
      echo "Error: Unsupported flag $1" >&2
      usage 1
      ;;
    *) # Collect filenames
      FILES+=("$1")
      shift
      ;;
  esac
done

# Check if any files were provided
if [ ${#FILES[@]} -eq 0 ]; then
  echo "Error: No files specified." >&2
  usage 1
fi

# --- Main Logic ---

SUDO_CMD=""
# Check if target directory exists and is writable, otherwise prepare to use sudo
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory ${TARGET_DIR} does not exist. Creating it with sudo."
    sudo mkdir -p "$TARGET_DIR"
fi

if [ ! -w "$TARGET_DIR" ]; then
    echo "You don't have write permissions for ${TARGET_DIR}. Using sudo..."
    SUDO_CMD="sudo"
    # Validate sudo credentials at the beginning
    $SUDO_CMD -v
fi

# Process each file
for file in "${FILES[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Warning: Source file '$file' not found. Skipping."
    continue
  fi

  source_path="$(realpath "$file")"
  dest_name=$(basename "$source_path")
  dest_path="${TARGET_DIR}/${dest_name}"

  if [ "$FORCE" = true ]; then
    echo "Force-installing '${dest_name}' to '${TARGET_DIR}'..."
    $SUDO_CMD ln -sf "$source_path" "$dest_path"
  else
    echo "Installing '${dest_name}' to '${TARGET_DIR}'..."
    $SUDO_CMD ln -s "$source_path" "$dest_path"
  fi
done

echo "Installation complete."
