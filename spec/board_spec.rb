# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  subject(:board) { described_class.new }
  describe '#create_board' do
    it 'should create an nested array with 7 rows' do
      board.create_board
      expect(board.board.count).to eq(7)
    end

    it 'each row should have an array with size of 7' do
      board.create_board
      board.board.each do |row|
        expect(row.size).to eq(7)
      end
    end

    it 'the values inside all the array should be ◯ except for last row' do
      board.create_board
      board.board.each_with_index do |row, idx|
        break if idx == board.board.size - 1

        row.each do |value|
          expect(value).to eq('◯')
        end
      end
    end

    it 'the last row should have integers from 1 to 7' do
      board.create_board
      expected_row = %w[1 2 3 4 5 6 7]
      expect(board.board.last).to eq(expected_row)
    end
  end
end
