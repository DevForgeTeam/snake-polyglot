from __future__ import annotations

from dataclasses import dataclass
import math
import random

import pygame

from audio import AudioEngine
from effects import ParticleBurst


@dataclass(slots=True)
class Food:
    grid: pygame.Vector2
    pulse: float = 0.0


class SnakeGame:
    cell_size = 32
    columns = 20
    rows = 20
    step_seconds = 0.12

    def __init__(self) -> None:
        pygame.init()
        self.audio = AudioEngine()
        self.audio.initialize()

        self.width = self.columns * self.cell_size
        self.height = self.rows * self.cell_size
        self.screen = pygame.display.set_mode((self.width, self.height))
        pygame.display.set_caption("snak3")
        self.clock = pygame.time.Clock()
        self.font = pygame.font.SysFont("arial", 28, bold=True)
        self.small_font = pygame.font.SysFont("arial", 18)

        self.running = True
        self.accumulator = 0.0
        self.score = 0
        self.high_score = 0
        self.game_over = False
        self.direction = pygame.Vector2(1, 0)
        self.next_direction = pygame.Vector2(1, 0)
        self.snake: list[pygame.Vector2] = []
        self.pending_growth = 0
        self.effects = ParticleBurst()
        self.food = Food(pygame.Vector2(0, 0))
        self.background_particles = [
            pygame.Vector2(random.uniform(0, self.width), random.uniform(0, self.height))
            for _ in range(28)
        ]
        self.reset(play_sound=False)

    def reset(self, play_sound: bool = True) -> None:
        center = pygame.Vector2(self.columns // 2, self.rows // 2)
        self.snake = [center.copy(), center - pygame.Vector2(1, 0), center - pygame.Vector2(2, 0)]
        self.direction = pygame.Vector2(1, 0)
        self.next_direction = pygame.Vector2(1, 0)
        self.pending_growth = 0
        self.score = 0
        self.game_over = False
        self.accumulator = 0.0
        self.effects = ParticleBurst()
        self.food = Food(self._spawn_food(), 0.0)
        if play_sound:
            self.audio.play_restart()

    def run(self) -> None:
        while self.running:
            dt = self.clock.tick(60) / 1000.0
            self._handle_events()
            self._update(dt)
            self._draw()
        pygame.quit()

    def _handle_events(self) -> None:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                self.running = False
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_ESCAPE:
                    self.running = False
                elif event.key in (pygame.K_UP, pygame.K_w):
                    self._queue_direction(pygame.Vector2(0, -1))
                elif event.key in (pygame.K_DOWN, pygame.K_s):
                    self._queue_direction(pygame.Vector2(0, 1))
                elif event.key in (pygame.K_LEFT, pygame.K_a):
                    self._queue_direction(pygame.Vector2(-1, 0))
                elif event.key in (pygame.K_RIGHT, pygame.K_d):
                    self._queue_direction(pygame.Vector2(1, 0))
                elif event.key in (pygame.K_SPACE, pygame.K_RETURN) and self.game_over:
                    self.reset()

    def _queue_direction(self, direction: pygame.Vector2) -> None:
        if direction == -self.direction:
            return
        self.next_direction = direction
        if self.game_over:
            self.reset()

    def _update(self, dt: float) -> None:
        self.food.pulse += dt
        self.effects.update(dt)
        for particle in self.background_particles:
            particle.y += 8.0 * dt
            if particle.y > self.height:
                particle.y = -10.0
                particle.x = random.uniform(0, self.width)

        if self.game_over:
            return

        self.accumulator += dt
        while self.accumulator >= self.step_seconds:
            self.accumulator -= self.step_seconds
            self._step()
            if self.game_over:
                break

    def _step(self) -> None:
        self.direction = self.next_direction
        new_head = self.snake[0] + self.direction
        occupied = self.snake if self.pending_growth > 0 else self.snake[:-1]

        if not self._in_bounds(new_head) or new_head in occupied:
            self.game_over = True
            self.high_score = max(self.high_score, self.score)
            self.audio.play_death()
            self.effects.emit(self._grid_to_center(self.snake[0]), pygame.Color(255, 120, 90), count=20)
            return

        self.snake.insert(0, new_head)

        if new_head == self.food.grid:
            self.score += 1
            self.high_score = max(self.high_score, self.score)
            self.pending_growth += 1
            self.audio.play_eat()
            self.effects.emit(self._grid_to_center(self.food.grid), pygame.Color(255, 208, 86), count=28)
            self.food = Food(self._spawn_food(), 0.0)
        elif self.pending_growth > 0:
            self.pending_growth -= 1
        else:
            self.snake.pop()

    def _draw(self) -> None:
        self.screen.fill((14, 18, 24))
        self._draw_background()
        self._draw_board()
        self._draw_food()
        self._draw_snake()
        self.effects.draw(self.screen, pygame.Vector2(0, 0))
        self._draw_hud()
        pygame.display.flip()

    def _draw_background(self) -> None:
        top_band = pygame.Rect(0, 0, self.width, self.height)
        pygame.draw.rect(self.screen, (18, 24, 32), top_band)
        overlay = pygame.Surface((self.width, self.height), pygame.SRCALPHA)
        overlay.fill((0, 0, 0, 0))
        for particle in self.background_particles:
            pygame.draw.circle(overlay, (255, 255, 255, 10), (int(particle.x), int(particle.y)), 1)
        self.screen.blit(overlay, (0, 0))

    def _draw_board(self) -> None:
        board = pygame.Rect(0, 0, self.width, self.rows * self.cell_size)
        pygame.draw.rect(self.screen, (22, 28, 38), board)
        grid_color = (30, 39, 50)
        for column in range(self.columns + 1):
            x = column * self.cell_size
            pygame.draw.line(self.screen, grid_color, (x, 0), (x, board.height), 1)
        for row in range(self.rows + 1):
            y = row * self.cell_size
            pygame.draw.line(self.screen, grid_color, (0, y), (self.width, y), 1)

    def _draw_snake(self) -> None:
        for index, segment in enumerate(self.snake):
            rect = pygame.Rect(
                segment.x * self.cell_size + 2,
                segment.y * self.cell_size + 2,
                self.cell_size - 4,
                self.cell_size - 4,
            )
            color = (125, 229, 143) if index == 0 else (84, 184, 110)
            pygame.draw.rect(self.screen, color, rect, border_radius=6)
            if index == 0:
                glow = pygame.Surface((self.cell_size + 10, self.cell_size + 10), pygame.SRCALPHA)
                pygame.draw.circle(glow, (170, 255, 185, 60), (glow.get_width() // 2, glow.get_height() // 2), self.cell_size // 2 + 2)
                self.screen.blit(glow, (segment.x * self.cell_size - 3, segment.y * self.cell_size - 3))

    def _draw_food(self) -> None:
        center = self._grid_to_center(self.food.grid)
        pulse = 1.0 + 0.08 * (1.0 + math.sin(self.food.pulse * 8.0))
        radius = int(self.cell_size * 0.34 * pulse)
        glow = pygame.Surface((radius * 4, radius * 4), pygame.SRCALPHA)
        pygame.draw.circle(glow, (255, 188, 74, 90), (radius * 2, radius * 2), radius * 2)
        self.screen.blit(glow, (center.x - radius * 2, center.y - radius * 2))
        pygame.draw.circle(self.screen, (255, 219, 112), (int(center.x), int(center.y)), radius)

    def _draw_hud(self) -> None:
        hud_rect = pygame.Rect(0, 0, self.width, 72)
        pygame.draw.rect(self.screen, (12, 15, 19), hud_rect)
        title = self.font.render(f"Score {self.score}", True, (242, 245, 248))
        best = self.small_font.render(f"Best {self.high_score}", True, (157, 171, 186))
        hint = self.small_font.render("Arrows/WASD to move  Space/Enter to restart  Esc to quit", True, (157, 171, 186))
        self.screen.blit(title, (18, 10))
        self.screen.blit(best, (18, 42))
        self.screen.blit(hint, (180, 26))

        if self.game_over:
            overlay = pygame.Surface((self.width, self.rows * self.cell_size), pygame.SRCALPHA)
            overlay.fill((8, 10, 14, 150))
            self.screen.blit(overlay, (0, 0))
            text = self.font.render("Game Over", True, (255, 245, 235))
            retry = self.small_font.render("Press Space or Enter to restart", True, (255, 220, 190))
            self.screen.blit(text, text.get_rect(center=(self.width / 2, self.rows * self.cell_size / 2 - 10)))
            self.screen.blit(retry, retry.get_rect(center=(self.width / 2, self.rows * self.cell_size / 2 + 22)))

    def _spawn_food(self) -> pygame.Vector2:
        available = [
            pygame.Vector2(column, row)
            for column in range(self.columns)
            for row in range(self.rows)
            if pygame.Vector2(column, row) not in self.snake
        ]
        if not available:
            return self.snake[0].copy()
        return random.choice(available)

    def _grid_to_center(self, grid: pygame.Vector2) -> pygame.Vector2:
        return pygame.Vector2(
            grid.x * self.cell_size + self.cell_size / 2,
            grid.y * self.cell_size + self.cell_size / 2,
        )

    def _in_bounds(self, grid: pygame.Vector2) -> bool:
        return 0 <= grid.x < self.columns and 0 <= grid.y < self.rows
