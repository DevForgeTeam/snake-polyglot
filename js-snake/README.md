# Snake Implementation (JavaScript)

A classic Snake game implemented in JavaScript using the HTML5 Canvas. This project is part of the **Snake Polyglot** showcase, which demonstrates how to build the same game in various programming languages following a shared set of rules.

## Dependencies

- A modern web browser that supports HTML5.

## Setup and Installation

There are no external dependencies to install. You just need a web browser.

## Running the Game

1.  Navigate to the `js-snake` directory.
2.  Open the `index.html` file in your web browser.

You can do this by double-clicking the file or right-clicking and selecting "Open with" your favorite browser.

## Game Controls

- **Move Up:** `W` or `Up Arrow`
- **Move Down:** `S` or `Down Arrow`
- **Move Left:** `A` or `Left Arrow`
- **Move Right:** `D` or `Right Arrow`
- **Restart:** `SPACE` (Available when Game Over)

## Project Structure

- `index.html`: The main entry point that hosts the game canvas.
- `style.css`: Basic styles for the game page.
- `src/`: Contains the JavaScript source code.
  - `settings.js`: Game constants like grid size and colors.
  - `game.js`: The core game logic class (`SnakeGame`).
  - `main.js`: Initializes the game and handles the main game loop.
