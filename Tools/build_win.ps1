$ErrorActionPreference = "Stop"
$GODOT = "C:\Tools\Godot_v4.x\Godot.exe"  # старік, отут треба вказати шлях який в тебе там буде до Godot

New-Item -ItemType Directory -Force -Path build | Out-Null
& $GODOT --headless --quit --export-debug "$EXPORT" "build/TrenchCommand_win.exe"
Write-Host "Win build: OK"
