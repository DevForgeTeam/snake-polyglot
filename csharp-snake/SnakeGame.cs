using System.Collections.Generic;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;

namespace csharp_snake;

// MonoGame Setup for Snake Game
public class SnakeGame : Microsoft.Xna.Framework.Game
{
    // MonoGame components
    private Texture2D _defaultTexture;
    private GraphicsDeviceManager _graphics;
    private SpriteBatch _spriteBatch;
    private Game _gameLogic;

    public SnakeGame()
    {
        _graphics = new GraphicsDeviceManager(this);

        // Set the graphics defaults.
        _graphics.PreferredBackBufferWidth = Config.WINDOW_SIZE;
        _graphics.PreferredBackBufferHeight = Config.WINDOW_SIZE;
        _graphics.IsFullScreen = false;

        // Apply the graphic presentation changes.
        _graphics.ApplyChanges();

        // Set the window title.
        Window.Title = Config.WINDOW_TITLE;

        Content.RootDirectory = "Content";
        IsMouseVisible = true;

    }

    protected override void Initialize()
    {
        // Game initialization logic here
        _gameLogic = new Game();


        base.Initialize();
    }

    protected override void LoadContent()
    {
        _spriteBatch = new SpriteBatch(GraphicsDevice);

        // Create a 1x1 pixel texture
        _defaultTexture = new Texture2D(GraphicsDevice, 1, 1);

        // Set the pixel color data to solid White
        _defaultTexture.SetData(new[] { Color.White });
    }

    protected override void Update(GameTime gameTime)
    {
        if (GamePad.GetState(PlayerIndex.One).Buttons.Back == ButtonState.Pressed || Keyboard.GetState().IsKeyDown(Keys.Escape))
            Exit();

        // Game pdate logic here

        base.Update(gameTime);
    }

    protected override void Draw(GameTime gameTime)
    {
        // Set the background color
        GraphicsDevice.Clear(Config.COLOR_BG);

        // Game drawing logic here

        //Draw the snake, food, and score here

        _spriteBatch.Begin();

        var snake = _gameLogic.GetSnake();
      
        for (int i = 0; i < snake.Count; i++)
        {
            DrawSnake( snake[i], i);
        }

        _spriteBatch.End();

        base.Draw(gameTime);
    }

    // Draw functions
    public void DrawSnake(Position segment, int i)
    {
          var color = i == 0 ? Config.COLOR_HEAD : Config.COLOR_SNAKE;
            var rect = new Rectangle(
                segment.X * Config.CELL_SIZE, segment.Y * Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE);
            _spriteBatch.Draw(_defaultTexture, rect, color);
    }
    public void DrawFood(Position segment)
    {
        var rect = new Rectangle(
            segment.X * Config.CELL_SIZE, segment.Y * Config.CELL_SIZE, Config.CELL_SIZE, Config.CELL_SIZE);
        _spriteBatch.Draw(_defaultTexture, rect, Config.COLOR_FOOD);
    }
    public void DrawScore(int score)
    {
        // Logic to draw the score on the screen
    }
}
