class GameOfLIfe {
    constructor(n){
        this.n = n;
        this.gen = [ 
        ['O', 'X', 'X'], 
        ['X', 'O', 'O'], 
        ['O', 'O',  'X']]
        // this.gen = []
        // for(let i = 0; i < this.n; i++) {
        //     const emptyCell = Array(3).fill('')
        //     // this.gen.push(new Array(this.n, ''))
        //     this.gen.push(emptyCell)
        // }

        // for(let i = 0; i < this.n; i++) {
        //     for(let j = 0; j < this.n; j++) {
        //         const cells = ['X', 'O']
        //         const randomizer = Math.floor(Math.random() * 2)
        //         // console.log(randomizer)
        //         this.gen[i][j] = cells[randomizer]
        //     }
        // }
    }



    // check function to see if its an X or O
    // Another function to then check the rules against what it is. 

    //loop

    traverseGen(){
        let nextGen = []
        for(let i = 0; i < this.n; i++) {
            nextGen.push([])
        }
        // console.log(nextGen)

        for(let i = 0; i < this.gen.length; i++) {
            
            for(let j = 0; j < this.gen.length; j++){
            
                if(this.checkAlive(i, j)){
                    let neighbors = this.findNeighbors(i, j)
                //    let cell = this.gen[i][j]
                   nextGen[i].push(this.aliveNeighbors(neighbors))
                   
                } else {
                    let neighbors = this.findNeighbors(i, j) 
                    nextGen[i].push(this.deadNeighbors(neighbors))
                }

            }
        }

        this.gen = nextGen
        return this.gen

    }

    runGenerations() {
        let count = 0; 
        let nextGen;
        while(count < 3) {
            nextGen = this.traverseGen()
            console.log(nextGen)
            if(nextGen.length > 0 && count !== 2) {
                    nextGen = ''
            }
            count++
        }
        return nextGen
    }


    checkAlive(row, col) {
        if(this.gen[row][col] === 'O') {
            return true; 
        } else {
            return false
        }
    }

    findNeighbors(row, col) {
        let neighbors = [];

        const directions = [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1,1], [1,0], [1, -1], [0, -1]]

        for(let direction of directions) {
            const [neighborRow, neighborCol] = direction
            if(this.checkBoundsDirection(row + neighborRow, col + neighborCol)) {
                neighbors.push(this.gen[row + neighborRow][col + neighborCol])
            }
        }
        
        return neighbors;

    }


    checkBoundsDirection(row, col) {
        const rowInBounds = 0 <= row && row < this.gen.length
        const colInBounds = 0 <= col && col < this.gen.length

        return rowInBounds && colInBounds
    }

    aliveNeighbors(neighbors) {
        if(neighbors.length < 2) {
            return 'X'
        }
        let countLive = 0; 
        let countDead = 0
        for(let neighbor of neighbors) {
            if(neighbor === 'O') {
                countLive++
            } else {
                countDead++
            }
        }

        if(countLive > 3 || countLive < 2) {
            return 'X'
        } else {
            return 'O'
        }

    }

    deadNeighbors(neighbors) {
        let count = 0; 
        for(let neighbor of neighbors) {
            if(neighbor === 'O') {
                count++
            }
        }

        if(count === 3) {
            return 'O'
        } else {
            return 'X'
        }
    }





    // checkRowBoundsUp(row) {
    //     return row - 1 >= 0

    // }

    // checkRowBoundsDown(row) {
    //     return row + 1 <= this.gen.length - 1
    // }

    // checkColumnBoundsRight(col) {
    //     return col + 1 <= this.gen.length - 1

    // }

    // checkColumnBoundsLeft(col) {
    //     return col - 1 >= 0
    // }

    // checkTopLeftBounds(row, col) {
    //     return this.checkRowBoundsUp(row) && this.checkColumnBoundsLeft(col)
    // }

    //1, 1

      // let cell = this.gen[row][col] 

        // if(this.checkRowBoundsUp(row)) {
        //     neighbors.push(this.gen[row -1][col])
        // }
        
        // if(this.checkRowBoundsDown(row)) {
        //     neighbors.push(this.gen[row + 1][col])
        // }

        // if(this.checkColumnBoundsRight(col)) {
        //     neighbors.push(this.gen[row][col + 1])
    
        // }

        // if(this.checkColumnBoundsLeft(col)) {
        //     neighbors.push(this.gen[row][col - 1])
    
        // }

        // if(this.checkTopLeftBounds(row, col)) {
        //     neighbors.push(this.gen[row -1][col - 1])
        // }




}

let game = new GameOfLIfe()

let game2 = new GameOfLIfe();

let game3 = new GameOfLIfe(3);

// console.log(game2.traverseGen())
console.log(game3.runGenerations())





//We would mutate it not in place 

//Any live cell with fewer than two live neighbours dies, as if by underpopulation.
//Any live cell with two or three live neighbours lives on to the next generation.
//Any live cell with more than three live neighbours dies, as if by overpopulation.
//Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.


// [
//     [ 'X', 'X', 'X' ], 
//     [ 'X', 'O', 'O' ], 
//     [ 'X', 'O', 'O' ] ]

//     ['X', 'X', 'X'],
//     ['X','O', 'O'],
//     ['X', 'O', 'O]

// Using diagnals or not we hit hit a wall by about the third generation. 

//github CoPilot