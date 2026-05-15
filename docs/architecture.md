# Snake Game Architecture

This document defines the shared gameplay and architecture rules for all Snake implementations inside this repository.

Every implementation should follow these rules as closely as possible to ensure consistency across programming languages.

---

# Core Gameplay Rules

## Grid System

- Grid Size: `20 x 20`
- Cell Size: `32px`
- Window Size: `640 x 640`

Formula:

```text
20 * 32 = 640
```

---

# Snake Rules

## Initial State

- Snake starts with length `3`
- Initial direction: `RIGHT`
- Snake starts near the center of the map

Example start position:

```text
[(10,10), (9,10), (8,10)]
```

---

# Movement Rules

- Snake moves one cell per update
- Snake cannot instantly reverse direction

Example:

- LEFT → RIGHT ❌
- UP → DOWN ❌

Allowed:

- LEFT → UP ✅
- LEFT → DOWN ✅

---

# Food Rules

- Only one food item exists at a time
- Food spawns randomly
- Food cannot spawn inside the snake body

When food is eaten:

- Snake grows by 1 segment
- Score increases by 1
- New food spawns

---

# Collision Rules

Game over happens when:

- Snake hits wall
- Snake hits itself

---

# Score Rules

- +1 score per food
- Current score visible on screen
- Optional high score support

---

# Game Speed

## Default

- 10 updates per second

Optional:

- Increase speed every 5 points

Example:

| Score | Speed |
|---|---|
| 0 | 10 |
| 5 | 12 |
| 10 | 14 |

---

# Controls

## Preferred Controls

| Action | Key |
|---|---|
| Move Up | W / Arrow Up |
| Move Down | S / Arrow Down |
| Move Left | A / Arrow Left |
| Move Right | D / Arrow Right |

---

# Required Features

Every implementation MUST include:

- Game loop
- Snake movement
- Food spawning
- Collision detection
- Score system
- Game over state

---

# Optional Features ITS OPTIONAL!

Implementations MAY include:

- Pause menu
- Difficulty settings
- Sound effects
- Animations
- High score saving
- Main menu
- Fullscreen mode

---

# Rendering Rules

## Snake

- Snake body should be clearly visible
- Head should be distinguishable if possible

## Food

- Food should use a different color or texture

## Background

- Simple dark or neutral background preferred

---

# Code Quality Rules

- Use meaningful variable names
- Keep functions small and readable
- Separate game logic from rendering logic
- Avoid hardcoded magic values
- Use constants/config values where possible

---

# Performance Goals

The game should:

- Run smoothly
- Avoid unnecessary memory allocations
- Maintain stable updates

---

# Final Note

The purpose of this repository is educational and collaborative.

Consistency between implementations is more important than adding language-specific custom features.
