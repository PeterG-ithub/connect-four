# frozen_string_literal: true

# Board class
class Board
  attr_reader :board

  def initialize(board = nil)
    @board = board
  end

  def create_board
    @board = Array.new(6) { Array.new(7, '◯') }
  end
end
