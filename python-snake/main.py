import pygame
import sys
from game.settings import *
from game.game import SnakeGame


def main():
    pygame.init()
    screen = pygame.display.set_mode((WINDOW_SIZE, WINDOW_SIZE))
    pygame.display.set_caption("Python Snake - Polyglot")
    clock = pygame.time.Clock()
    font = pygame.font.SysFont(None, 36)

    game = SnakeGame()

    while True:
        # Event handling
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif event.type == pygame.KEYDOWN:
                if game.game_over:
                    if event.key == pygame.K_SPACE:
                        game.reset()
                else:
                    if event.key in (pygame.K_UP, pygame.K_w):
                        game.handle_input((0, -1))
                    elif event.key in (pygame.K_DOWN, pygame.K_s):
                        game.handle_input((0, 1))
                    elif event.key in (pygame.K_LEFT, pygame.K_a):
                        game.handle_input((-1, 0))
                    elif event.key in (pygame.K_RIGHT, pygame.K_d):
                        game.handle_input((1, 0))

        game.update()

        # Rendering
        screen.fill(COLOR_BG)

        # This will Draw Food
        food_rect = pygame.Rect(
            game.food[0] * CELL_SIZE, game.food[1] * CELL_SIZE, CELL_SIZE, CELL_SIZE)
        pygame.draw.rect(screen, COLOR_FOOD, food_rect)

        # Draw Snake
        for i, segment in enumerate(game.snake):
            color = COLOR_HEAD if i == 0 else COLOR_SNAKE
            rect = pygame.Rect(
                segment[0] * CELL_SIZE, segment[1] * CELL_SIZE, CELL_SIZE, CELL_SIZE)
            pygame.draw.rect(screen, color, rect)

        # This will Show Score
        score_text = font.render(f"Score: {game.score}", True, COLOR_TEXT)
        screen.blit(score_text, (10, 10))

        if game.game_over:
            go_text = font.render(
                "Game Over! Press SPACE to restart.", True, COLOR_TEXT)
            go_rect = go_text.get_rect(
                center=(WINDOW_SIZE // 2, WINDOW_SIZE // 2))
            screen.blit(go_text, go_rect)

        pygame.display.flip()
        clock.tick(FPS)


if __name__ == "__main__":
    main()
