# frozen_string_literal: true

require_relative 'board'
class ConnectFour
  attr_reader :board
  def initialize(board = Board.new)
    @board = board
    @board.create_board
    @player = %w[1 2]
  end

  def verify_input(input)
  end

  def player_input
  end

  def change_turn(last_turn)
  end

  def whos_turn; end

  def check_column; end

  def game_board; end

  def change_board(player_input); end
end
