// Configuration File (per architecture.md)
using Microsoft.Xna.Framework;

namespace csharp_snake;
// Configuration for Snake Game
public static class Config
{
    // Game constants
    public static readonly string WINDOW_TITLE = "CSharp Snake";
    public static readonly int GRID_SIZE = 20;
    public static readonly int CELL_SIZE = 32;
    public static readonly int WINDOW_SIZE = GRID_SIZE * CELL_SIZE;
    public static readonly int INITIAL_SNAKE_LENGTH = 5;
    public static readonly int FPS = 10; // Frames per second
    public static readonly int SPEED_INCREMENT = 5; // Speed increase per score


    // Readonly fields for Colors
    public static readonly Color COLOR_BG = new Color(30, 30, 30);
    public static readonly Color COLOR_SNAKE = new Color(46, 204, 113);
    public static readonly Color COLOR_HEAD = new Color(39, 174, 96);
    public static readonly Color COLOR_FOOD = new Color(231, 76, 60);
    public static readonly Color COLOR_TEXT = new Color(236, 240, 241);
  
}