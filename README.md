# Sky Cube Runner 3D

## Overview
Sky Cube Runner 3D is a SwiftUI + SceneKit endless runner built for iOS 17+. Glide through neon lanes, dodge obstacles, and chase daily leaderboards with ghost replays.

## Features
- SwiftUI UI with glassmorphism styling and dark mode defaults
- SceneKit runner loop with physics collisions and SCNView renderer updates
- Object pooling, spawner, and difficulty scaling over time
- Scoring system with best score persistence
- HUD, game over flow, and detailed run summary
- Settings with audio, haptics, high contrast, debug overlay, and tutorial toggle
- Debug overlay with FPS, node count, and speed telemetry

## Pro Features
- Daily challenge seed with top-5 leaderboard
- Ghost replay of your last run
- Achievements with persistence
- Tutorial overlay for first-time players

## Project Structure
```
SkyCubeRunner3D/
  SkyCubeRunner3DApp.swift
  ContentView.swift
  Views/
  Game/
  Resources/
  Assets.xcassets/
SkyCubeRunner3DTests/
screenshots/
```

## How To Play
- Swipe left or right to change lanes.
- Avoid barriers and keep your speed high.
- Play the daily challenge to compare runs on the same seeded track.

## Settings & Accessibility
- High contrast toggle enhances HUD legibility.
- Dynamic Type is supported automatically through SwiftUI.
- Debug overlay can be enabled to inspect runtime metrics.

## Persistence
- Best score and settings are stored in `UserDefaults`.
- Daily leaderboards and achievements persist per device.

## Requirements
- Xcode 15.0+
- iOS 17+
- Swift 5.9

## Setup
1. Open `SkyCubeRunner3D.xcodeproj` in Xcode.
2. Select an iOS 17 simulator or device.
3. Build and run.

## Testing
Run unit tests from Xcode (`⌘U`).

## Push to GitHub

### Option A: Terminal (fast + reliable)

```bash
cd skycube_fix
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/Mealiclay01/sky-cube-runner-3d.git
git push -u origin main
```

### Option B: Xcode UI

1. In Xcode: **Source Control → New Git Repositories…** (create a repo inside the project folder).
2. Then: **Source Control → Push…** and choose your GitHub remote.
3. If you don’t see your remote: **Source Control → Remotes… → Add Remote…** and paste the repo URL.

Tip: If you get permission errors, make sure you’re logged into GitHub in Xcode (**Xcode → Settings → Accounts**) or use SSH.

## Credits
Created for the Sky Cube Runner 3D prototype. Placeholder assets and audio were generated programmatically.

## Screenshots
See `/screenshots` for placeholder captures.
