using Microsoft.Xna.Framework.Input;
using System.Collections.Generic;

namespace csharp_snake;
public readonly record struct Position(int X, int Y);
// Logic Layer For Snake Game
public class Game
{
    private int score = 0;
    private int speed = Config.FPS;
    private Snake snake;
    private Food food;
    private Score scoreManager;
    private bool isGameOver = false;


    // Get the current state of keyboard input.
    KeyboardState keyboardState = Keyboard.GetState();

    public Game()
    {
        // Initialize game state
        ResetGame();

    }


    public void StartGame()
    {
        // Start game state
        food.SpawnFood();   
    }
    public void EndGame()
    {
        // Handle game over logic
        isGameOver = true;
    }
    public void ResetGame()
    {
        isGameOver = false;
        score = 0;
        speed = Config.FPS;
        snake = new Snake();
        food = new Food();
        scoreManager = new Score();
    }
    public List<Position> GetSnake()
    {
        return snake.GetSnake();
    }
    public Food GetFood(){
        return food;
    }
    public Score GetScore(){
        return scoreManager;
    }

    public void HandleUserInput()
    {
        // Input handling here

        // Check if the space key is down.
        if(keyboardState.IsKeyDown(Keys.Space))
        {
            // The space key is down, so do something.
        }
        // UP Direction   
        if(keyboardState.IsKeyDown(Keys.W) || keyboardState.IsKeyDown(Keys.Up))
        {
           
        }
        // DOWN Direction   
        if(keyboardState.IsKeyDown(Keys.S) || keyboardState.IsKeyDown(Keys.Down))
        {
           
        }
        // LEFT Direction   
        if(keyboardState.IsKeyDown(Keys.A) || keyboardState.IsKeyDown(Keys.Left))
        {
           
        }
        // RIGHT Direction   
        if(keyboardState.IsKeyDown(Keys.D) || keyboardState.IsKeyDown(Keys.Right))
        {
           
        }
    }



}