# frozen_string_literal: true

require_relative 'board'
class ConnectFour
  attr_reader :board

  def initialize(board = Board.new)
    @board = board
    @board.create_board
    @player_turn = '1'
  end

  def play_game
    introduction
    loop do
      input = player_input
      change_board(input)
    end
  end

  def verify_input(input)
    return nil unless input.is_a? Integer
    return input if input.between?(1, 7)
  end

  def player_input
    loop do
      player_input = gets.chomp
      input = verify_input(player_input.to_i)
      return input if input

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
      if %w[1 2 3 4 5 6 7].include?(row[input - 1])
        idx += 1
        next
      end
      break
    end
    return (6 - idx) unless idx == 7

    nil
  end

  def valid_column(col)
    loop do
      row = check_column(col)
      return [row, col] if row

      puts 'Column full! Please input in another column'
      col = player_input
    end
  end

  def change_board(input)
    row, col = valid_column(input)
    @board.board[row][col - 1] = whos_turn
    display_board
    change_turn
  end

  def introduction
    puts 'Welcome to Connect Four'
    puts 'The first player to Connect four numbers wins'
    display_board
    display_help
    display_turn
  end

  def display_board
    @board.display_board
  end

  def display_turn
    puts "Player #{whos_turn}'s turn: "
  end

  def display_help
    puts 'Input a number from 1 to 7'
  end

  def game_over?
    return true if win_column || win_row || win_diagonal

    false
  end

  def win_row
    previous_val = nil
    count = 1
    @board.board.each do |row|
      row.each do |val|
        if val == previous_val && %w[1 2].include?(val)
          count += 1
        else
          count = 1
        end
        return true if count == 4

        previous_val = val
      end
    end
    false
  end

  def win_column
    previous_val = nil
    count = 1
    arr = @board.board.transpose
    arr.each do |row|
      row.each_with_index do |val, idx|
        next if idx == 6

        if val == previous_val && %w[1 2].include?(val)
          count += 1
        else
          count = 1
        end
        return true if count == 4

        previous_val = val
      end
    end
    false
  end

  def win_diagonal
    return true if right_diagonal || left_diagonal

    false
  end
  
  def right_diagonal

  end

  def left_diagonal
  end
end

# connect_four = ConnectFour.new
# connect_four.play_game
