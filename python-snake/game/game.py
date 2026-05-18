import random
from .settings import GRID_SIZE

class SnakeGame:
    def __init__(self):
        self.reset()

    def reset(self):
        """Resets the game to the initial state."""
        self.snake = [(10, 10), (9, 10), (8, 10)]
        self.direction = (1, 0)  # RIGHT
        self.next_direction = (1, 0)
        self.score = 0
        self.game_over = False
        self.food = self._get_random_food()

    def _get_random_food(self):
        """Will Draw food in a random location not already occupied by the snake."""
        while True:
            food = (random.randint(0, GRID_SIZE - 1), random.randint(0, GRID_SIZE - 1))
            if food not in self.snake:
                return food

    def handle_input(self, next_dir):
        """Prevents instant reverse."""
        if self.direction[0] != -next_dir[0] or self.direction[1] != -next_dir[1]:
            self.next_direction = next_dir

    def update(self):
        """Advances the game state by one tick."""
        if self.game_over:
            return

        self.direction = self.next_direction
        head_x, head_y = self.snake[0]
        new_head = (head_x + self.direction[0], head_y + self.direction[1])

        # This detects collision
        if (new_head[0] < 0 or new_head[0] >= GRID_SIZE or
            new_head[1] < 0 or new_head[1] >= GRID_SIZE or
            new_head in self.snake):
            self.game_over = True
            return

        self.snake.insert(0, new_head)
        if new_head == self.food:
            self.score += 1
            self.food = self._get_random_food()
        else:
            self.snake.pop()