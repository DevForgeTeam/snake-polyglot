from __future__ import annotations

from array import array
import math
from dataclasses import dataclass

import pygame


@dataclass(slots=True)
class SoundBank:
    eat: pygame.mixer.Sound | None
    death: pygame.mixer.Sound | None
    restart: pygame.mixer.Sound | None


class AudioEngine:
    def __init__(self) -> None:
        self.enabled = False
        self.sounds = SoundBank(None, None, None)

    def initialize(self) -> None:
        if self.enabled:
            return

        try:
            pygame.mixer.pre_init(44100, -16, 1, 512)
            pygame.mixer.init()
            self.sounds = SoundBank(
                eat=self._tone(880, 0.09, 0.45, 0.015),
                death=self._tone(180, 0.18, 0.7, 0.03),
                restart=self._tone(660, 0.08, 0.35, 0.01),
            )
            self.enabled = True
        except pygame.error:
            self.enabled = False
            self.sounds = SoundBank(None, None, None)

    def play_eat(self) -> None:
        self._play(self.sounds.eat)

    def play_death(self) -> None:
        self._play(self.sounds.death)

    def play_restart(self) -> None:
        self._play(self.sounds.restart)

    def _play(self, sound: pygame.mixer.Sound | None) -> None:
        if self.enabled and sound is not None:
            sound.play()

    def _tone(
        self,
        frequency: float,
        duration: float,
        volume: float,
        fade: float,
    ) -> pygame.mixer.Sound:
        sample_rate = 44100
        sample_count = max(1, int(sample_rate * duration))
        buffer = array("h")

        for index in range(sample_count):
            time_position = index / sample_rate
            envelope = 1.0
            if fade > 0:
                attack = min(1.0, time_position / fade)
                release = min(1.0, (duration - time_position) / fade)
                envelope = max(0.0, min(attack, release))
            wave = math.sin(2.0 * math.pi * frequency * time_position)
            sample = int(32767 * volume * envelope * wave)
            buffer.append(sample)

        return pygame.mixer.Sound(buffer=buffer.tobytes())
