class GameOfLife 
    attr_reader :gen
    def initialize(n)
        @n = n; 
        @gen = [ ['O', 'X', 'X'], 
                 ['X', 'O', 'O'], 
                 ['O', 'O',  'X']]
    end

    def traverseGen
        nextGen = []
        for i in 0..2
            nextGen.push([])
        end

        for i in 0..@gen.length - 1
            for j in 0..@gen.length - 1
                if self.checkAlive(i, j)
                    neighbors = self.findNeighbors(i, j)
                    nextGen[i].push(self.aliveNeighbors(neighbors))

                else
                    neighbors = self.findNeighbors(i, j)
                    nextGen[i].push(self.deadNeighbors(neighbors))
                end
            end
        end



        @gen = nextGen
        nextGen


    end

    def runGeneration 
        count = 0
        while count < 3
        nextGen = self.traverseGen
        #puts nextGen
            if nextGen.length > 0 && count != 2
                nextGen = ''
            end
            count += 1
        end
        nextGen
    end



    def checkAlive(row, col)
        if @gen[row][col] == 'O'
            return true
        end
            return false
    end




    def findNeighbors(row, col) 
        neighbors = []
        directions = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1,1], [1,0], [1, -1], [0, -1]]

        directions.each do |direction|
            neighborRow = direction[0]
            neighborCol = direction[1]
            if self.checkBoundsDirection(row + neighborRow, col + neighborCol)
                neighbors.push(@gen[row + neighborRow][col + neighborCol])

            end
        end
        return neighbors
        
    end


    def checkBoundsDirection(row, col) 
        rowInBounds = 0 <= row && row < @gen.length
        colInBounds = 0 <= col && col < @gen.length
        return rowInBounds && colInBounds
    end



    def aliveNeighbors(neighbors) 
        if neighbors.length < 2 
            return 'X'
        end
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
            return 'X'
        else
            return 'O'
        end

    end




    def deadNeighbors(neighbors) 

        count = 0

        neighbors.each do |neighbor|
            if neighbor == 'O'
                count += 1
            end
        end

        if count == 3
            return 'O'
        else
            return 'X'
        end


    end


end

game = GameOfLife.new(3)
p game.runGeneration