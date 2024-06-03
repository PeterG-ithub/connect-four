# Connect Four Game

This is a simple implementation of the classic Connect Four game in Ruby. Connect Four is a two-player game in which players take turns dropping colored discs into a grid. The objective of the game is to connect four of one's own discs of the same color next to each other vertically, horizontally, or diagonally before your opponent does.

## Installation

### Prerequisites

- Ruby installed on your system

### Windows

1. Ensure you have Ruby installed. If not, download and install it from [here](https://www.ruby-lang.org/en/downloads/).
2. Clone this repository to your local machine.
    ```bash
        git clone git@github.com:PeterG-ithub/connect-four.git
3. Navigate to the directory where you cloned the repository.
    ```bash
        cd connect-four
4. Run `main.rb` to start the game.
    ```bash
        ruby .\lib\main.rb  

### Linux

1. Open a terminal.
2. Ensure you have Ruby installed by running `ruby --version`. 
    ```bash
        ruby --version
If not, install Ruby using your package manager.
    ```bash
        sudo apt update
        sudo apt-get install ruby-full

3. Clone this repository to your local machine.
    ```bash
        git clone git@github.com:PeterG-ithub/connect-four.git
4. Navigate to the directory where you cloned the repository.
    ```bash
        cd connect-four
5. Run `main.rb` to start the game.
    ```bash
        ruby lib/main.rb


## How to Play

- The game is played on a 6x7 grid where players take turns dropping their colored discs (◯ or ●) into one of the seven columns.
- The objective is to connect four of your discs in a row either horizontally, vertically, or diagonally.
- Players input the column number where they want to drop their disc.
- The first player to connect four discs wins the game.
- Enjoy playing against a friend or challenge yourself against an AI opponent.

## Features

- Simple command-line interface for easy gameplay.
- Two-player mode for playing against a friend.
- Dynamic board size for future expansion.
- Ability to save and load game state for resuming play later.

## Testing

The codebase is thoroughly tested with RSpec to ensure the functionality and correctness of the Connect Four game. Various tests cover different aspects of the game logic, including player input validation, turn switching, checking for a win condition, and more. 

For detailed information on the tests and their results, please refer to the [`spec`](spec/) directory in the repository.

## Credits

This Ruby Project is part of the curriculum provided by [The Odin Project](https://www.theodinproject.com/), an open-source online platform that offers free resources to learn web development.
- Website: [The Odin Project](https://www.theodinproject.com/)
- Connect Four Project: [Connect Four](https://www.theodinproject.com/lessons/connect-four)
