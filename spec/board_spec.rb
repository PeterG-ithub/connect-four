# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#create_board' do
    subject(:board) { Board.new }
    it 'should create an nested array with 7 columns and 6 rows' do
      board.create_board
      expect(board.board.count).to eq(7).and board.board[0].count.to eq(6)
    end

    it 'the values inside all the array should be ◯' do
    end
  end
end
