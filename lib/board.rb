# frozen_string_literal: true

# Board class
class Board
  attr_reader :board

  def initialize(board = nil)
    @board = board
  end

  def create_board
    @board = Array.new(6) { Array.new(7, '◯') }
    @board << %w[1 2 3 4 5 6 7]
  end

  def display_board
    @board.each { |row| puts row.join(' ') }
  end
end

board = Board.new
board.create_board
board.display_board
