# Snake Polyglot Showcase

---
Hello Team!
“Please do not rush; I recommend doing it slowly. Everyone should learn step by step 🙂 Thank you very much.”

First, read the architecture.md file. The rules are fixed. Once the Python reference implementation is complete, it will be ported one-to-one into other languages.
---


A multi-language implementation of the classic Snake game.

This repository was created as a collaborative engineering showcase project
to compare different programming languages, architectures, tooling, and
development approaches using the same game concept.

---

# Goal

The purpose of this project is to implement the classic Snake game in multiple programming languages while keeping the gameplay and rules consistent.

Each implementation should follow similar mechanics:

- Same movement system
- Same scoring logic
- Same grid size
- Same gameplay rules
- Similar controls where possible

This allows easier comparison between languages and ecosystems.

---

# Languages & Frameworks

| Language | Framework |
|---|---|---|
| Python | pygame |
| C++ | SFML |
| C# | MonoGame / .NET |
| Java | JavaFX |
| Rust | macroquad |

---

# Repository Structure

```text
snake-polyglot/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── docs/
│   ├── architecture.md
│   ├── comparison.md
│   └── benchmarks.md
│
├── assets/
├── screenshots/
│
├── python-snake/
├── cpp-snake/
├── csharp-snake/
├── java-snake/
├── rust-snake/
│
└── .github/
    └── workflows/
```

---

# Project Rules

To keep the repository organized, please follow these rules:

## General Rules

- Keep code clean and readable
- Use meaningful commit messages
- Follow the existing folder structure
- Avoid uploading unnecessary binaries
- Document important changes
- Keep gameplay behavior consistent across implementations

---

# Gameplay Requirements

Each Snake implementation should include:

- Snake movement
- Food spawning
- Collision detection
- Score system
- Game over screen

Optional features: (OPTIONAL!)

- Pause menu
- High score saving
- Sound effects
- Difficulty settings
- Animations

---

# Branch Strategy

Please create feature branches instead of pushing directly to `main`.

Examples:

```bash
feature/python-game-loop
feature/cpp-render-system
feature/java-input-handler
feature/rust-collision-system
```

---

# Commit Convention

Examples:

```bash
feat(python): add snake movement
feat(cpp): implement collision detection
fix(java): resolve keyboard input issue
docs: update setup instructions
```

---

# How To Contribute

1. Fork or clone the repository
2. Create a new feature branch
3. Implement your changes
4. Test your implementation
5. Open a Pull Request

---

# Setup Instructions

Each language implementation contains its own setup guide inside its folder.

Example:

```bash
cd python-snake
```

or

```bash
cd rust-snake
```

---

# Suggested Technologies

| Language | Suggested Framework |
|---|---|
| Python | pygame |
| C++ | SFML |
| C# | MonoGame |
| Java | JavaFX |
| Rust | macroquad |

---

# Planned Documentation

The `/docs` folder will contain:

- architecture.md
- comparison.md
- benchmarks.md
- setup-guide.md

---

# License

This project is licensed under the MIT License.

---

# Contributors

Thanks to everyone contributing to this project.

DevForge-Team!
