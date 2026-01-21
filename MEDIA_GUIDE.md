# Media Guide (Screenshots & GIFs)

This guide explains how to capture and optimize media for **Sky Cube Runner 3D**.
All assets should live in `/screenshots` and use the exact filenames referenced in `README.md`.

## Target Files
- `screenshots/hero.png` (1280×640 recommended)
- `screenshots/screenshot1.png`
- `screenshots/screenshot2.png`
- `screenshots/screenshot3.png`
- `screenshots/gameplay.gif` (8–15 seconds, optimized)

## Capture Screenshots (iOS Simulator)
1. Run the project in the iOS Simulator.
2. Navigate to a visually strong scene (HUD, gameplay, game-over).
3. Use **File → Save Screenshot** (or `⌘S`).

## Record Gameplay GIF (iOS Simulator)
### Option A — Record Video → Convert to GIF
1. In Simulator, use **File → Record Screen**.
2. Stop recording after 8–15 seconds.
3. Convert using `ffmpeg`:

```bash
# Convert MOV to optimized GIF
ffmpeg -i input.mov -vf "fps=12,scale=640:-1:flags=lanczos" -loop 0 screenshots/gameplay.gif
```

### Option B — Use `gifski` (Higher Quality)
```bash
# Install (macOS)
brew install gifski

# Convert MP4/MOV to GIF
ffmpeg -i input.mov -vf "fps=12,scale=640:-1:flags=lanczos" /tmp/frames-%04d.png
gifski /tmp/frames-*.png -o screenshots/gameplay.gif
```

## Optimization Tips
- Keep GIF under **10MB**.
- Prefer 640px width for GIFs.
- Use 10–15 FPS to reduce size while staying smooth.
- For PNG screenshots, use `pngquant` if needed:

```bash
brew install pngquant
pngquant --quality=70-90 --ext .png --force screenshots/screenshot1.png
```

## Replace Placeholders
The current media assets are placeholders. Replace them with real in-game captures before client delivery.
