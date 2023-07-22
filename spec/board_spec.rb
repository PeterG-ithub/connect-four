# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  describe '#create_board' do
    it 'should create an nested array with 6 rows' do
      board.create_board
      expect(board.board.count).to eq(6)
    end

    it 'each row should have an array with size of 7' do
      board.create_board
      board.board.each do |row|
        expect(row.size).to eq(7)
      end
    end

    it 'the values inside all the array should be ◯' do
      board.create_board
      board.board.each do |row|
        row.each do |value|
          expect(value).to eq('◯')
        end
      end
    end
  end
end
