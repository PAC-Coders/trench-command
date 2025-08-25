$ErrorActionPreference = "Stop"

# якщо GODOT_BIN є в env — беремо його, інакше дефолт
if ($env:GODOT_BIN) {
    $GODOT = $env:GODOT_BIN
} else {
    $GODOT = "D:\Programs\Godot\Godot_v4.4.1-stable_win64.exe"
}

$EXPORT = "Windows Desktop"

New-Item -ItemType Directory -Force -Path build | Out-Null
& $GODOT --headless --quit --export-debug "$EXPORT" "build/TrenchCommand_win.exe"
Write-Host "Win build: OK"