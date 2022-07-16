require_relative '../lib/game'

describe Game do
  let(:player_blue) { instance_double('Player', name: 'Sam', token: Token.new('blue')) }
  let(:player_red) { instance_double('Player', name: 'Ali', token: Token.new('red')) }

  describe '#turn_order' do
    let(:board_turn) { instance_double('Board') }
    subject(:game_turn) { described_class.new(player_blue, player_red, board_turn) }

    before do
      allow(game_turn).to receive(:switch_player).and_return(player_blue)
      allow(game_turn).to receive(:player_input).and_return(3)
    end

    it 'inserts token of correct player' do
      expect(board_turn).to receive(:insert_token).with(player_blue.token, 3).once
      game_turn.turn_order
    end
  end

  describe '#player_input' do
    subject(:game_input) { described_class.new(player_blue, player_red) }

    context 'when incorrect value is given once, then correct value' do
      before do
        valid_input = 4
        allow(game_input).to receive(:print)
        allow(game_input).to receive(:verify_input).and_return(nil, valid_input)
      end

      it 'gives error once' do
        expect(game_input).to receive(:print).with('Invalid input! Please enter a col no (0-6):').once
        game_input.player_input(player_blue)
      end
      it 'returns value' do
        result = game_input.player_input(player_blue)
        expect(result).to eq(4)
      end
    end

    context 'when incorrect value is given 3 times' do
      before do
        valid_input = 4
        allow(game_input).to receive(:print)
        allow(game_input).to receive(:verify_input).and_return(nil, nil, nil, valid_input)
      end

      it 'gives error 3 times' do
        expect(game_input).to receive(:print).with('Invalid input! Please enter a col no (0-6):').exactly(3).times
        game_input.player_input(player_blue)
      end
      it 'returns value' do
        result = game_input.player_input(player_blue)
        expect(result).to eq(4)
      end
    end

    context 'when correct value is given only' do
      before do
        valid_input = 4
        allow(game_input).to receive(:print)
        allow(game_input).to receive(:verify_input).and_return(valid_input)
      end

      it 'gives no error' do
        expect(game_input).to_not receive(:print).with('Invalid input! Please enter a col no (0-6):')
        game_input.player_input(player_blue)
      end
      it 'returns value' do
        result = game_input.player_input(player_blue)
        expect(result).to eq(4)
      end
    end
  end

  describe '#verify_input' do
    let(:board_verify) { instance_double('Board') }
    subject(:game_verify) { described_class.new(player_blue, player_red, board_verify) }

    context 'when invalid number is given' do
      it 'returns nil' do
        invalid_num = '7'
        result = game_verify.verify_input(invalid_num)
        expect(result).to be_nil
      end
    end

    context 'when string is given' do
      it 'returns nil' do
        str = 'ab'
        result = game_verify.verify_input(str)
        expect(result).to be_nil
      end
    end

    context 'when input is valid but given coloumn is full' do
      before do
        allow(board_verify).to receive(:coloumn_full?).and_return(true)
      end

      it 'returns nil' do
        valid_input = '4'
        result = game_verify.verify_input(valid_input)
        expect(result).to be_nil
      end
    end

    context 'when input is valid and coloumn has space' do
      before do
        allow(board_verify).to receive(:coloumn_full?).and_return(false)
      end

      it 'returns input' do
        valid_input = '4'
        result = game_verify.verify_input(valid_input)
        expect(result).to eq(valid_input.to_i)
      end
    end
  end

  describe '#game_over?' do
    let(:board_over) { instance_double('Board') }
    subject(:game_end) { described_class.new(player_blue, player_red, board_over) }

    context 'when board is full' do
      before do
        allow(board_over).to receive(:connected_four?).and_return(nil)
        allow(board_over).to receive(:full?).and_return(true)
      end

      it 'returns true' do
        result = game_end.game_over?
        expect(result).to be true
      end
    end

    context 'when 4 are connected' do
      before do
        winning_token = Token.new('red')
        allow(board_over).to receive(:connected_four?).and_return(winning_token)
        allow(board_over).to receive(:full?).and_return(false)
      end

      it 'returns winning token' do
        winning_token = Token.new('red')
        result = game_end.game_over?
        expect(result).to eq(winning_token)
      end
    end

    context 'when neither board is full nor 4 are connected' do
      before do
        allow(board_over).to receive(:connected_four?).and_return(nil)
        allow(board_over).to receive(:full?).and_return(false)
      end

      it 'returns false' do
        result = game_end.game_over?
        expect(result).to be false
      end
    end 
  end

  describe '#switch_player' do
    subject(:game_switch) { described_class.new(player_blue, player_red) }

    it 'switches current player (player at index[0])' do
      expect { game_switch.switch_player }.to change { game_switch.instance_variable_get(:@players)[0] }.
      from(player_blue).to(player_red)
    end

    it 'returns current player' do
      curr_player = game_switch.switch_player
      expect(curr_player).to eq(player_red)
    end
  end
end