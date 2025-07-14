#!/usr/bin/env bats

# Load test libraries relative to this test file.
load 'libs/bats-support/load.bash'
load 'libs/bats-assert/load.bash'

# --- Setup: Runs before each test --- 
setup() {
  # bats runs tests from the project root, so paths are relative to there.
  # Create a temporary directory to act as /usr/local/bin
  TMP_BIN_DIR="$(mktemp -d)"
  # Create some dummy script files to be "installed"
  touch script1.sh
  touch script2.py
  chmod +x script1.sh script2.py

  # Override the TARGET_DIR in the script to use our temp directory
  sed -i.bak 's|TARGET_DIR="/usr/local/bin"|TARGET_DIR="'"$TMP_BIN_DIR"'"|' install.sh
}

# --- Teardown: Runs after each test --- 
teardown() {
  # Clean up the temporary directory and dummy files
  rm -rf "$TMP_BIN_DIR"
  rm -f script1.sh script2.py

  # Restore the original install.sh from backup
  mv install.sh.bak install.sh
}

# --- Test Cases ---

@test "1. Installs a single file successfully" {
  run ./install.sh script1.sh
  
  assert_success
  assert_output --partial "Installing 'script1.sh'"
  assert [ -L "$TMP_BIN_DIR/script1.sh" ] # Check if symlink exists
}

@test "2. Installs multiple files successfully" {
  run ./install.sh script1.sh script2.py

  assert_success
  assert_output --partial "Installing 'script1.sh'"
  assert_output --partial "Installing 'script2.py'"
  assert [ -L "$TMP_BIN_DIR/script1.sh" ]
  assert [ -L "$TMP_BIN_DIR/script2.py" ]
}

@test "3. Shows help message with -h flag" {
  run ./install.sh -h

  assert_success
  assert_output --partial "Usage: install.sh [options]"
}

@test "4. Force flag (-f) overwrites an existing link" {
  # First, create a dummy file where the link will be
  touch "$TMP_BIN_DIR/script1.sh"

  run ./install.sh -f script1.sh

  assert_success
  assert_output --partial "Force-installing 'script1.sh'"
  assert [ -L "$TMP_BIN_DIR/script1.sh" ] # Ensure it's a link now
}

@test "5. Fails to install without force flag if file exists" {
  # Create a dummy file where the link will be
  touch "$TMP_BIN_DIR/script1.sh"

  # We expect this to fail because ln -s will not overwrite
  run ./install.sh script1.sh

  assert_failure
  assert_output --partial "File exists"
}

@test "6. Skips non-existent source files" {
  run ./install.sh non_existent_file.sh

  assert_success # The script itself shouldn't fail
  assert_output --partial "Warning: Source file 'non_existent_file.sh' not found. Skipping."
}

@test "7. Shows usage and error if no files are specified" {
  run ./install.sh

  assert_failure
  assert_output --partial "Error: No files specified."
}
