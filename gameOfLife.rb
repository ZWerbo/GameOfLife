# frozen_string_literal: true

class GameOfLife
  ALIVE_MARKER = 'O'
  DEAD_MARKER = 'X'
  attr_reader :gen

  def initialize(grid)
    #@n = n
    #@generation = [%w[O ,'X' X],
    #        %w[X O O],
    #        %w[O O X]]
    @generation = grid
  end

  def traverse_gen
    next_gen = []
    (1..@generation.length).each do 
      next_gen.push([])
    end

    (0..@generation.length - 1).each do |i|
      (0..@generation.length - 1).each do |j|
        neighbors = find_neighbors(i, j)
        if checkAlive(i, j)
          next_gen[i].push(alive_neighbors_evolve(neighbors))
        else
          next_gen[i].push(dead_neighbors_evolve(neighbors))
        end
      end
    end

    @generation = next_gen
    next_gen
  end

  def run_generation(n)
    count = 0
    while count < n
      next_gen = traverse_gen
      #puts next_gen
      #next_gen = '' if next_gen.length.positive? && count != n
      count += 1
    end
    next_gen
  end

  def checkAlive(row, col)
   @generation[row][col] == ALIVE_MARKER
  end

  def find_neighbors(row, col)
    neighbors = []
    directions = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]

    directions.each do |direction|
      neighborRow = direction[0]
      neighborCol = direction[1]
      if checkBoundsDirection(row + neighborRow, col + neighborCol)
        neighbors.push(@generation[row + neighborRow][col + neighborCol])

      end
    end
    neighbors
  end

  def checkBoundsDirection(row, col)
    rowInBounds = row >= 0 && row < @generation.length
    colInBounds = col >= 0 && col < @generation.length
    rowInBounds && colInBounds
  end

  def alive_neighbors_evolve(neighbors)
    return DEAD_MARKER if neighbors.length < 2

    countLive = 0
    countDead = 0

    neighbors.each do |neighbor|
      if neighbor == ALIVE_MARKER
        countLive += 1
      else
        countDead += 1
      end
    end

    if countLive > 3 || countLive < 2
      DEAD_MARKER
    else
      ALIVE_MARKER
    end
  end

  def dead_neighbors_evolve(neighbors)
    count = 0

    neighbors.each do |neighbor|
      count += 1 if neighbor == ALIVE_MARKER
    end

    if count == 3
      ALIVE_MARKER
    else
      DEAD_MARKER
    end
  end
end

game = GameOfLife.new([['O', 'X', 'X'], ['X', 'O', 'O'], ['O','O' ,'X']])
#game._g()
p game.traverse_gen

