require_relative '../lib/board'

describe Board do
  describe '#insert_token' do
    subject(:board_insert) { Board.new }

    context 'when inserted in an empty coloumn' do
      it 'falls to the last slot' do
        token = Token.new('blue')
        board_insert.insert_token(token, 0)
        expect(board_insert.grid[5][0]).to eql(token)
      end
    end

    context 'when inserted in a partially filled coloumn' do
      before do
        2.times { |i| board_insert.grid[5 - i][0] = Token.new('red') }
      end

      it 'falls to lowest available slot' do
        token = Token.new('blue')
        board_insert.insert_token(token, 0)
        expect(board_insert.grid[3][0]).to eql(token)
      end
    end

    context 'when inserted in a full coloumn' do
      before do
        allow(board_insert).to receive(:coloumn_full?).and_return(true)
      end

      it 'throws an Exception' do
        token = Token.new('blue')
        expect { board_insert.insert_token(token, 0) }.to raise_exception('Coloumn is full')
      end
    end
  end

  describe '#connected_four?' do
    subject(:board_connect) { Board.new }

    before do
      for i in 3..5 do board_connect.grid[5][i] = Token.new('green') end
      for i in 3..4 do board_connect.grid[4][i] = Token.new('green') end
      for i in 3..5 do board_connect.grid[i][6] = Token.new('red') end
      board_connect.grid[3][3] = Token.new('green')    # Sets up the bottom right of the board as such:
      board_connect.grid[3][5] = Token.new('green')    #   ● ○ ● ○    ● -> green
      board_connect.grid[3][4] = Token.new('red')      #   ● ● ○ ○    ○ -> red
      board_connect.grid[4][5] = Token.new('red')      #   ● ● ● ○    to allow for all outcumes easily.
    end

    context 'when at least 4 are connected horizontally' do
      before do
        board_connect.grid[5][2] = Token.new('green')
      end

      it 'returns winning token' do
        winning_token = Token.new('green')
        result = board_connect.connected_four?
        expect(result).to eq(Token.new('green'))
      end
    end

    context 'when at least 4 are connected vertically' do
      before do
        board_connect.grid[2][6] = Token.new('red')
      end

      it 'returns winning token' do
        winning_token = Token.new('red')
        result = board_connect.connected_four?
        expect(result).to eq(winning_token)
      end
    end

    context 'when at least 4 are connected on a leading diagonal' do
      before do
        board_connect.grid[2][6] = Token.new('green')
      end

      it 'returns winning token' do
        winning_token = Token.new('green')
        result = board_connect.connected_four?
        expect(result).to eq(winning_token)
      end
    end

    context 'when at least 4 are connected on a main diagonal' do
      before do
        board_connect.grid[2][3] = Token.new('red')
      end

      it 'returns winning token' do
        winning_token = Token.new('red')
        result = board_connect.connected_four?
        expect(result).to eq(winning_token)
      end
    end

    context 'when 4 are not connected' do
      it 'returns nil' do
        result = board_connect.connected_four?
        expect(result).to be_nil
      end
    end
  end

  describe '#full?' do
    subject(:board_fill) { Board.new }

    context 'when board is full' do
      before do
        board_fill.grid.map! { |row| row.map! { Token.new('red') } }
      end

      it 'returns true' do
        expect(board_fill.full?).to be true
      end
    end

    context 'when board is empty' do
      it 'returns false' do
        expect(board_fill.full?).to be false
      end
    end

    context 'when board is partially filled' do
      before do
        6.times { |i| board_fill.grid[5 - i][0] = Token.new('red') }
      end

      it 'returns false' do
        expect(board_fill.full?).to be false
      end
    end
  end

  describe '#coloumn_full?' do
    subject(:board_col_fill) { Board.new }

    context 'when coloumn is full' do
      before do
        6.times { |i| board_col_fill.grid[5 - i][0] = Token.new('red') }
      end

      it 'returns true' do
        result = board_col_fill.coloumn_full?(0)
        expect(result).to be true
      end
    end

    context 'when coloumn is empty' do
      it 'returns false' do
        result = board_col_fill.coloumn_full?(0)
        expect(result).to be false
      end
    end

    context 'when coloumn is partially filled' do
      before do
        3.times { |i| board_col_fill.grid[5 - i][0] = Token.new('red') }
      end

      it 'returns false' do
        result = board_col_fill.coloumn_full?(0)
        expect(result).to be false
      end
    end
  end
end