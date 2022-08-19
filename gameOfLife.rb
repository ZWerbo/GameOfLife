# frozen_string_literal: true

class GameOfLife
  attr_reader :gen

  def initialize(n)
    @n = n
    @gen = [%w[O X X],
            %w[X O O],
            %w[O O X]]
  end

  def traverseGen
    nextGen = []
    (0..2).each do |_i|
      nextGen.push([])
    end

    (0..@gen.length - 1).each do |i|
      (0..@gen.length - 1).each do |j|
        neighbors = findNeighbors(i, j)
        if checkAlive(i, j)
          nextGen[i].push(aliveNeighbors(neighbors))

        else
          nextGen[i].push(deadNeighbors(neighbors))
        end
      end
    end

    @gen = nextGen
    nextGen
  end

  def runGeneration
    count = 0
    while count < 3
      nextGen = traverseGen
      # puts nextGen
      nextGen = '' if nextGen.length.positive? && count != 2
      count += 1
    end
    nextGen
  end

  def checkAlive(row, col)
    return true if @gen[row][col] == 'O'

    false
  end

  def findNeighbors(row, col)
    neighbors = []
    directions = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]

    directions.each do |direction|
      neighborRow = direction[0]
      neighborCol = direction[1]
      if checkBoundsDirection(row + neighborRow, col + neighborCol)
        neighbors.push(@gen[row + neighborRow][col + neighborCol])

      end
    end
    neighbors
  end

  def checkBoundsDirection(row, col)
    rowInBounds = row >= 0 && row < @gen.length
    colInBounds = col >= 0 && col < @gen.length
    rowInBounds && colInBounds
  end

  def aliveNeighbors(neighbors)
    return 'X' if neighbors.length < 2

    countLive = 0
    countDead = 0

    neighbors.each do |neighbor|
      if neighbor == 'O'
        countLive += 1
      else
        countDead += 1
      end
    end

    if countLive > 3 || countLive < 2
      'X'
    else
      'O'
    end
  end

  def deadNeighbors(neighbors)
    count = 0

    neighbors.each do |neighbor|
      count += 1 if neighbor == 'O'
    end

    if count == 3
      'O'
    else
      'X'
    end
  end
end

game = GameOfLife.new(3)
p game.runGeneration
