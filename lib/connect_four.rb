# frozen_string_literal: true

require_relative 'board'
class ConnectFour
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
    @board.create_board
    @player_turn = '1'
  end

  def verify_input(input)
    return nil unless input.is_a? Integer
    return input if input.between?(1, 7)
  end

  def player_input
    loop do
      player_input = gets.chomp
      input = verify_input(player_input.to_i)
      break if input

      puts 'Input error! Please enter a number between 1 and 7'
    end
  end

  def change_turn(last_turn = whos_turn)
    if last_turn == '2'
      @player_turn = '1'
      '1'
    else
      @player_turn = '2'
      '2'
    end
  end

  def whos_turn
    @player_turn
  end

  def check_column(input)
    idx = 0
    @board.board.reverse_each do |row|
      if %w[1 2 3 4 5 6 7].include?(row[input])
        idx += 1
        next
      end
      break
    end
    return (6 - idx) unless idx == 7

    nil
  end

  def change_board(input)
    row = check_column(input)
    @board.board[row][input] = whos_turn
  end
end
