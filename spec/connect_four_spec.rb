# frozen_string_literal: true

require_relative '../lib/connect_four'

describe ConnectFour do
  describe '#verify_input' do
    subject(:game_input) { described_class.new }

    context 'when given a valid input' do
      valid_input = 3
      it 'returns valid input' do
        results = game_input.verify_input(valid_input)
        expect(results).to eq(3)
      end
    end

    context 'when given an integer but out of range input' do
      valid_input = 8
      it 'returns nil' do
        results = game_input.verify_input(valid_input)
        expect(results).to eq(nil)
      end
    end

    context 'when given invalid input' do
      invalid_input = 'a'
      it 'returns nil' do
        results = game_input.verify_input(invalid_input)
        expect(results).to eq(nil)
      end
    end
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new }
    context 'when user input a valid input' do
      before do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end
      it 'stops loop and return the same valid input' do
        error_message = 'Input error! Please enter a number between 1 and 7'
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.player_input
      end
    end

    context 'when a user enters a valid input, it will return that input as integer' do
      before do
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end
      it 'should return integer 3' do
        results = game_input.player_input
        expect(results).to be(3)
      end
    end

    context 'when user input a invalid input 3 times then a valid input after' do
      before do
        invalid_input1 = 'a'
        invalid_input2 = 'asd'
        invalid_input3 = '11'
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(invalid_input1, invalid_input2, invalid_input3, valid_input)
      end
      it 'matches the error three times and stops when valid input' do
        error_message = 'Input error! Please enter a number between 1 and 7'
        expect(game_input).to receive(:puts).with(error_message).exactly(3).times
        game_input.player_input
      end
    end
  end

  describe '#change_turn' do
    subject(:game_turn) { described_class.new }
    context 'everytime this method is called, the players switch turn' do
      it 'changes turn from player 1 to player 2' do
        last_turn = '1'
        current_turn = game_turn.change_turn(last_turn)
        expect(current_turn).to be('2')
      end

      it 'changes turn from player 2 to palyer 1' do
        last_turn = '2'
        current_turn = game_turn.change_turn(last_turn)
        expect(current_turn).to be('1')
      end
    end
  end

  describe '#whos_turn' do
    subject(:game_turn) { described_class.new }
    context 'when called, returns who\'s turn it is' do
      it 'returns player 1' do
        current_turn = game_turn.whos_turn
        expect(current_turn).to be('1')
      end

      it 'returns player 2' do
        game_turn.change_turn('player 1')
        current_turn = game_turn.whos_turn
        expect(current_turn).to be('2')
      end
    end
  end

  describe '#check_column' do
    subject(:game_column) { described_class.new }
    context 'check the availability of a given column, column starts from 1 to 7' do
      player_input = 7

      it 'returns which row is good' do
        results = game_column.check_column(player_input)
        expect(results).to be(5)
      end

      it 'returns which row is good' do
        game_column.board.board.each_with_index do |row, idx|
          row[player_input - 1] = '1' if idx.between?(3, 5)
        end
        results = game_column.check_column(player_input)
        expect(results).to be(2)
      end

      it 'returns nil' do
        game_column.board.board.each_with_index do |row, idx|
          row[player_input - 1] = '1' if idx < 6
        end
        results = game_column.check_column(player_input)
        expect(results).to be(nil)
      end
    end
  end

  describe '#valid_column' do
    subject(:game_column) { described_class.new }
    context 'when given a valid input, return the valid input' do
      valid_column = 3
      it 'should return [row, col]' do
        results = game_column.valid_column(valid_column)
        expect(results).to eq([5, 3])
      end
    end

    # context 'when given nil from #check_column' do
    #   it 'should return an error message until valid input' do
    #     allow(game_column).to receive(:check_column).and_return(nil)
    #     error_message = 'Column full! Please input in another column'
    #     game_column.valid_column(3)
    #     expect(game_column).to receive(:puts).with(error_message)
    #   end
    # end
  end

  describe '#change_board' do
    subject(:game) { described_class.new }
    context 'when player input is 3' do
      player_input = 3
      it 'will change board in row 6, col 3 to 1' do
        allow(game).to receive(:whos_turn).and_return('1')
        allow(game).to receive(:check_column).and_return(5)
        game.change_board(player_input)
        expect(game.board.board[5][2]).to be('1')
      end

      it 'will change board in row 6, col 3 to 2' do
        allow(game).to receive(:whos_turn).and_return('2')
        allow(game).to receive(:check_column).and_return(5)
        game.change_board(player_input)
        expect(game.board.board[5][2]).to be('2')
      end

      it 'will make sure the input is an integer' do
        expect(player_input).to be_a Integer
      end
    end
  end

  describe '#game_over?' do
    subject(:game_state) { described_class.new }
    context 'method should determine if game is over' do
      before do
        allow(game_state).to receive(:win_row).and_return(false)
        allow(game_state).to receive(:win_column).and_return(false)
        allow(game_state).to receive(:win_diagonal).and_return(false)
      end
      it 'should return false if not game over' do
        results = game_state.game_over?
        expect(results).to be(false)
      end
      it 'should return true if win_row is true' do
        allow(game_state).to receive(:win_row).and_return(true)
        results = game_state.game_over?
        expect(results).to be(true)
      end
      it 'should return true if win_column is true' do
        allow(game_state).to receive(:win_column).and_return(true)
        results = game_state.game_over?
        expect(results).to be(true)
      end
      it 'should return true if win_diagonal is true' do
        allow(game_state).to receive(:win_diagonal).and_return(true)
        results = game_state.game_over?
        expect(results).to be(true)
      end
    end
  end

  describe '#win_row' do
    subject(:game_winner) { described_class.new }
    context 'method should determine if there is a four of a kind in a row' do
      before do
        game_winner.board.board[5][0] = '1'
        game_winner.board.board[5][1] = '1'
        game_winner.board.board[5][2] = '1'
        game_winner.board.board[5][3] = '1'
      end
      it 'should return true' do
        game_winner.board.display_board
        results = game_winner.win_row
        expect(results).to be(true)
      end

      it 'should return false' do
        game_winner.board.board[5][3] = '2'
        game_winner.board.display_board
        results = game_winner.win_row
        expect(results).to be(false)
      end
    end
  end

  describe '#win_column' do
    subject(:game_winner) { described_class.new }
    context 'method should determine if there is a four of a kind in a column' do
      before do
        game_winner.board.board[2][5] = '2'
        game_winner.board.board[3][5] = '2'
        game_winner.board.board[4][5] = '2'
        game_winner.board.board[5][5] = '2'
      end
      it 'should return true' do
        game_winner.board.display_board
        results = game_winner.win_column
        expect(results).to be(true)
      end

      it 'should return false' do
        game_winner.board.board[5][5] = '1'
        game_winner.board.display_board
        results = game_winner.win_column
        expect(results).to be(false)
      end
    end
  end

  describe '#win_diagonal' do
    subject(:game_winner) { described_class.new }
    context 'method should determine if there is a four of a kind in a row' do
      before do
        allow(game_winner).to receive(:right_diagonal).and_return(false)
        allow(game_winner).to receive(:left_diagonal).and_return(false)
      end
      it 'should return false' do
        results = game_winner.win_diagonal
        expect(results).to be(false)
      end

      it 'should return true' do
        allow(game_winner).to receive(:right_diagonal).and_return(true)
        results = game_winner.win_diagonal
        expect(results).to be(true)
      end

      it 'should return false' do
        allow(game_winner).to receive(:left_diagonal).and_return(true)
        results = game_winner.win_diagonal
        expect(results).to be(true)
      end
    end
  end

  describe '#right_diagonal' do
    subject(:game_winner) { described_class.new }
    context 'method should determine if there is a four of a kind in a column' do
      before do
        game_winner.board.board[0][6] = '2'
        game_winner.board.board[1][5] = '2'
        game_winner.board.board[2][4] = '2'
        game_winner.board.board[3][3] = '2'
      end
      it 'should return true' do
        game_winner.board.display_board
        results = game_winner.right_diagonal
        expect(results).to be(true)
      end

      it 'should return false' do
        game_winner.board.board[0][6] = '1'
        game_winner.board.display_board
        results = game_winner.right_diagonal
        expect(results).to be(false)
      end
    end
  end

  describe '#left_diagonal' do
    subject(:game_winner) { described_class.new }
    context 'method should determine if there is a four of a kind in a column' do
      before do
        game_winner.board.board[0][0] = '2'
        game_winner.board.board[1][1] = '2'
        game_winner.board.board[2][2] = '2'
        game_winner.board.board[3][3] = '2'
      end
      it 'should return true' do
        game_winner.board.display_board
        results = game_winner.left_diagonal
        expect(results).to be(true)
      end

      it 'should return false' do
        game_winner.board.board[0][0] = '1'
        game_winner.board.display_board
        results = game_winner.left_diagonal
        expect(results).to be(false)
      end
    end
  end
end
