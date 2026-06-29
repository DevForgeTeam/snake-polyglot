class SnakeGame {
  constructor() {
    this.reset();
  }

  reset() {
    this.snake = [
      { x: 10, y: 10 },
      { x: 9, y: 10 },
      { x: 8, y: 10 },
    ];
    this.direction = { x: 1, y: 0 };
    this.nextDirection = { x: 1, y: 0 };
    this.score = 0;
    this.gameOver = false;
    this.food = this._getRandomFood();
  }

  _getRandomFood() {
    let food;
    while (true) {
      food = {
        x: Math.floor(Math.random() * GRID_SIZE),
        y: Math.floor(Math.random() * GRID_SIZE),
      };
      if (
        !this.snake.some(
          (segment) => segment.x === food.x && segment.y === food.y,
        )
      ) {
        return food;
      }
    }
  }

  handleInput(nextDir) {
    if (this.direction.x !== -nextDir.x || this.direction.y !== -nextDir.y) {
      this.nextDirection = nextDir;
    }
  }

  update() {
    if (this.gameOver) return;

    this.direction = this.nextDirection;
    const head = {
      x: this.snake[0].x + this.direction.x,
      y: this.snake[0].y + this.direction.y,
    };

    if (
      head.x < 0 ||
      head.x >= GRID_SIZE ||
      head.y < 0 ||
      head.y >= GRID_SIZE ||
      this.snake.some((segment) => segment.x === head.x && segment.y === head.y)
    ) {
      this.gameOver = true;
      return;
    }

    this.snake.unshift(head);

    if (head.x === this.food.x && head.y === this.food.y) {
      this.score++;
      this.food = this._getRandomFood();
    } else {
      this.snake.pop();
    }
  }
}
