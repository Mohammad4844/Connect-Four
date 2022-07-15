require_relative '../lib/game'

describe Game do
  describe '#play' do
    context 'when game is over' do
      xit 'ends game' do
      end
    end
  end

  describe '#turn_order' do
    xit 'switches currect player' do
    end

    xit 'insert token' do
    end
  end

  describe '#player_input' do
    context 'when incorrect value is given once' do
      xit 'gives error once' do
      end
    end

    context 'when incorrect value is given 3 times' do
      xit 'gives error 3 times' do
      end
    end

    context 'when correct value is given' do
      xit 'gives no error' do
      end
      xit 'returns value' do
      end
    end
  end

  describe '#verify_input' do
    context 'when invalid number is given' do
      xit 'returns nil' do
      end
    end

    context 'when string is given' do
      xit 'returns nil' do
      end
    end

    context 'when given coloumn is full' do
      xit 'returns nil' do
      end
    end

    context 'when input is valid' do
      xit 'returns input' do
      end
    end
  end

  describe '#game_over?' do
    context 'when board is full' do
      xit 'returns true' do
      end
    end

    context 'when 4 are connected' do
      xit 'returns true' do
      end
    end

    context 'when neither board is full nor 4 are connected' do
      xit 'returns false' do
      end
    end
  end 
end