using System.Collections.Generic;


namespace csharp_snake;

// Snake Class
public class Snake
{
    private List<Position> snake = new List<Position> { new Position(10, 10), new Position(9, 10), new Position(8, 10) };
    private Position direction = new Position(1, 0);
    private Position nextDirection = new Position(1, 0);

    public void Reset()
    {
        // Resets the game to the initial state.
        snake = new List<Position> { new Position(10, 10), new Position(9, 10), new Position(8, 10) };
        direction = new Position(1, 0);
        nextDirection = new Position(1, 0);
    }

    public List<Position> GetSnake()
    {
        return snake;
    }

    public Position GetDirection()
    {
        return direction;
    }

    public Position GetNextDirection()
    {
        return nextDirection;
    }


    public void Move()
    {
        // Logic to move the snake
    }
    public void MoveHead()
    {
        // Logic to change the snake's direction
    }
    public void CalculateNewHead()
    {
        // Logic to calculate the new head position based on the current direction
    }
    public void SnakeCollisionSelf()
    {
        // Logic to check if the snake collides with itself
    }
    public void SnakeCollisionWall()
    {
        // Logic to check if the snake collides with the wall
    }
    public void StopSnake()
    {
        // Logic to stop the snake's movement
    }

}