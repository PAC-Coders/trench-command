$ErrorActionPreference = "Stop"
$GODOT = "D:\Programs\Godot\Godot_v4.4.1-stable_win64.exe"

New-Item -ItemType Directory -Force -Path build | Out-Null
& $GODOT --headless --quit --export-debug "$EXPORT" "build/TrenchCommand_win.exe"
Write-Host "Win build: OK"
