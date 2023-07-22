describe ConnectFour do
  describe '#verify_input' do
    subject(:game_input) { described_class.new }
    context 'when given a valid input' do
      valid_input = 3
      results = game_input.verify_input(valid_input)
      it 'returns valid input' do
        expect(results).to be(3)
      end
    end

    context 'when given invalid input' do
      invalid_input = 'a'
      results = game_input.verify_input(invalid_input)
      it 'returns nil' do
        expect(results).to be(nil)
      end
    end
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new }
    context 'when user input a valid input' do
      before do
        valid_input = '3'
        allow(game_input).to recieve(:gets).and_return(valid_input)
      end
      it 'stops loop and return the same valid input' do
        error_message = 'Input error! Please enter a number between 1 and 7'
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.player_input
      end
    end

    context 'when user input a invalid input then a valid input after' do
      before do
        invalid_input = 'a'
        valid_input = '3'
        allow(game_input).to recieve(:gets).and_return(invalid_input, valid_input)
      end
      it 'stops loop and return the same valid input' do
        error_message = 'Input error! Please enter a number between 1 and 7'
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.player_input
      end
    end

    context 'when user input a invalid input 3 times then a valid input after' do
      before do
        invalid_input1 = 'a'
        invalid_input2 = 'asd'
        invalid_input3 = '11'
        valid_input = '3'
        allow(game_input).to recieve(:gets).and_return(invalid_input1, invalid_input2, invalid_input3, valid_input)
      end
      it 'stops loop and return the same valid input' do
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
        last_turn = 'player 1'
        current_turn = game_turn.change_turn(last_turn)
        expect(current_turn).to be('player 2')
      end

      it 'changes turn from player 2 to palyer 1' do
        last_turn = 'player 2'
        current_turn = game_turn.change_turn(last_turn)
        expect(current_turn).to be('player 1')
      end
    end
  end

  describe '#whos_turn' do
    subject(:game_turn) { described_class.new }
    context 'when called, returns who\'s turn it is' do
      it 'returns player 1' do
        current_turn = game_turn.whos_turn
        expect(current_turn).to be('player 1')
      end

      it 'returns player 2' do
        game_turn.change_turn('player 1')
        current_turn = game_turn.whos_turn
        expect(current_turn).to be('player 2')
      end
    end
  end
end
