# Trench Command — MVP

## Run locally
1) Install Godot 4.x  
2) Open the project → F5 (Windows) or Cmd+B (MacOS)
3) Local build: `Tools/build_win.ps1` (Windows) or `Tools/build_mac.sh` (macOS)

## Builds & Versions

- **Snapshots:** Every push to `main` and every PR upload builds as GitHub Actions **Artifacts** (kept 14 days).
- **Milestones/Playtests:** Push a tag (e.g., `v0.3.0`, `v0.3.0-rc.1`). CI publishes a **GitHub Release** with builds + checksums.
- **Filenames:** `TrenchCommand_win_v<version>.exe`, `TrenchCommand_mac_v<version>.zip`.
- **Where:** See the repo’s **Actions** (snapshots) and **Releases** (milestones).
