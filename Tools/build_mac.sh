#!/usr/bin/env bash
set -euo pipefail
GODOT="$HOME/Applications/Godot.app/Contents/MacOS/Godot"
EXPORT="macOS"

mkdir -p build
"$GODOT" --headless --quit --export-debug "$EXPORT" "build/TrenchCommand_mac.zip"
echo "macOS build: OK"
