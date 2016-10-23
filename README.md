# pa-mazes

Represents a n by m maze in an appropriately designed class called Maze. Each position in the maze can be designated by two coordinates, x (across) and y (down). For a 4x5 maze the top row of positions (x,y) would be (0,0), (1,0), (2, 0) and (3,0). The constructor of the Maze class takes two parameters for n and m.

Implements a Maze#load(arg) method that initializes the maze using a string of ones and zeros as above.

Implements a Maze#display method that prints a diagram of the maze on the console.

Implements a Maze#solve(begX, begY, endX, endY) method that determines if there’s a way to walk from a specified beginning position to a specified ending position.

Implements a Maze#trace(begX, begY, endX, endY) method that is just like solve() but traces the positions that the solution visits.
