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
        if check_alive(i, j)
          next_gen[i].push(alive_neighbors_evolve(neighbors))
        else
          next_gen[i].push(dead_neighbors_evolve(neighbors))
        end
      end
    end

    @generation = next_gen
    next_gen
  end

  def run_generation(num)
    count = 0
    while count < num
      next_gen = traverse_gen
      #puts next_gen
      #next_gen = '' if next_gen.length.positive? && count != n
      count += 1
    end
    next_gen
  end

  def check_alive(row, col)
    @generation[row][col] == ALIVE_MARKER
  end

  def find_neighbors(row, col)
    neighbors = []
    directions = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]]

    directions.each do |direction|
      neighbor_row = direction[0]
      neighbor_col = direction[1]
      if check_bounds_direction(row + neighbor_row, col + neighbor_col)
        neighbors.push(@generation[row + neighbor_row][col + neighbor_col])

      end
    end
    neighbors
  end

  def check_bounds_direction(row, col)
    row_in_bounds = row >= 0 && row < @generation.length
    col_in_bounds = col >= 0 && col < @generation.length
    row_in_bounds && col_in_bounds
  end

  def alive_neighbors_evolve(neighbors)
    return DEAD_MARKER if neighbors.length < 2

    count_live = 0
    count_dead = 0

    neighbors.each do |neighbor|
      if neighbor == ALIVE_MARKER
        count_live += 1
      else
        count_dead += 1
      end
    end

    if count_live > 3 || count_live < 2
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

game = GameOfLife.new([['O', 'X', 'X'], ['X', 'O', 'O'], ['O','O','X']])
#p game.traverse_gen

p game.run_generation(6)

