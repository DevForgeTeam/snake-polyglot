document.addEventListener("DOMContentLoaded", () => {
  const canvas = document.getElementById("gameCanvas");
  const ctx = canvas.getContext("2d");

  const game = new SnakeGame();

  function resizeCanvas() {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;

    WINDOW_SIZE = Math.min(canvas.width, canvas.height);
    CELL_SIZE = WINDOW_SIZE / GRID_SIZE;

    render();
  }

  function gameLoop() {
    if (!game.gameOver) {
      game.update();
    }
    render();
  }

  function render() {
    const offsetX = (canvas.width - WINDOW_SIZE) / 2;
    const offsetY = (canvas.height - WINDOW_SIZE) / 2;

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = "#2c3e50";
    ctx.fillRect(offsetX, offsetY, WINDOW_SIZE, WINDOW_SIZE);

    ctx.fillStyle = COLOR_FOOD;
    ctx.fillRect(
      offsetX + game.food.x * CELL_SIZE,
      offsetY + game.food.y * CELL_SIZE,
      CELL_SIZE,
      CELL_SIZE,
    );

    game.snake.forEach((segment, index) => {
      ctx.fillStyle = index === 0 ? COLOR_HEAD : COLOR_SNAKE;
      ctx.fillRect(
        offsetX + segment.x * CELL_SIZE,
        offsetY + segment.y * CELL_SIZE,
        CELL_SIZE,
        CELL_SIZE,
      );
    });

    ctx.fillStyle = COLOR_TEXT;
    ctx.font = "24px sans-serif";
    ctx.fillText(`Score: ${game.score}`, 10, 30);

    if (game.gameOver) {
      ctx.fillStyle = COLOR_TEXT;
      ctx.font = "36px sans-serif";
      ctx.textAlign = "center";
      ctx.fillText("Game Over!", canvas.width / 2, canvas.height / 2 - 20);
      ctx.font = "24px sans-serif";
      ctx.fillText(
        "Press SPACE to restart",
        canvas.width / 2,
        canvas.height / 2 + 20,
      );
      ctx.textAlign = "left";
    }
  }

  document.addEventListener("keydown", (e) => {
    if (game.gameOver) {
      if (e.code === "Space") {
        game.reset();
      }
      return;
    }

    switch (e.key) {
      case "w":
      case "ArrowUp":
        game.handleInput({ x: 0, y: -1 });
        break;
      case "s":
      case "ArrowDown":
        game.handleInput({ x: 0, y: 1 });
        break;
      case "a":
      case "ArrowLeft":
        game.handleInput({ x: -1, y: 0 });
        break;
      case "d":
      case "ArrowRight":
        game.handleInput({ x: 1, y: 0 });
        break;
    }
  });

  window.addEventListener("resize", resizeCanvas);

  setInterval(gameLoop, 1000 / FPS);

  resizeCanvas();
});
