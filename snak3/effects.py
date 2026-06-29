from __future__ import annotations

from dataclasses import dataclass
import math
import random

import pygame


@dataclass(slots=True)
class Particle:
    position: pygame.Vector2
    velocity: pygame.Vector2
    life: float
    max_life: float
    radius: float
    color: pygame.Color

    def update(self, dt: float) -> bool:
        self.position += self.velocity * dt
        self.velocity *= 0.92
        self.life -= dt
        return self.life > 0

    def draw(self, surface: pygame.Surface, offset: pygame.Vector2) -> None:
        alpha = max(0, min(255, int(255 * (self.life / self.max_life))))
        radius = max(1, int(self.radius * (0.6 + 0.4 * (self.life / self.max_life))))
        color = (*self.color[:3], alpha)
        particle_surface = pygame.Surface((radius * 2 + 2, radius * 2 + 2), pygame.SRCALPHA)
        pygame.draw.circle(particle_surface, color, (radius + 1, radius + 1), radius)
        surface.blit(particle_surface, (self.position.x - radius - offset.x, self.position.y - radius - offset.y))


class ParticleBurst:
    def __init__(self) -> None:
        self.particles: list[Particle] = []

    def emit(self, center: pygame.Vector2, color: pygame.Color, count: int = 18) -> None:
        for _ in range(count):
            angle = random.uniform(0.0, 6.283185307179586)
            speed = random.uniform(70.0, 210.0)
            velocity = pygame.Vector2(math.cos(angle), math.sin(angle)) * speed
            self.particles.append(
                Particle(
                    position=center.copy(),
                    velocity=velocity,
                    life=random.uniform(0.22, 0.5),
                    max_life=0.5,
                    radius=random.uniform(2.0, 5.0),
                    color=color,
                )
            )

    def update(self, dt: float) -> None:
        self.particles = [particle for particle in self.particles if particle.update(dt)]

    def draw(self, surface: pygame.Surface, offset: pygame.Vector2) -> None:
        for particle in self.particles:
            particle.draw(surface, offset)

    def active(self) -> bool:
        return bool(self.particles)
