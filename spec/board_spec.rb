require_relative '../lib/board'

describe Board do
  describe '#insert_token' do
    context 'when inserted in an empty coloumn' do
      xit 'falls to the last slot' do
      end
    end

    context 'when inserted in a partially filled coloumn' do
      xit 'falls to lowest available slot' do
      end
    end

    context 'when inserted in a full coloumn' do
      xit 'throws a InvalidArgument Exception' do
      end
    end
  end

  describe '#connected_four?' do
    context 'when at least 4 are connected horizontally' do
      xit 'returns winning token' do
      end
    end

    context 'when at least 4 are connected vaertically' do
      xit 'returns winning token' do
      end
    end

    context 'when at least 4 are connected on a main diagonal' do
      xit 'returns winning token' do
      end
    end

    context 'when at least 4 are connected on a leading diagonal' do
      xit 'returns winning token' do
      end
    end

    context 'when 4 are not connected' do
      xit 'returns nil' do
      end
    end
  end

  describe '#full?' do
    context 'when board is full' do
      xit 'returns true' do
      end
    end

    context 'when board is empty' do
      xit 'returns false' do
      end
    end

    context 'when board is partially filled' do
      xit 'returns false' do
      end
    end
  end

  describe '#coloumn_full?' do
    context 'when coloumn is full' do
      xit 'returns true' do
      end
    end

    context 'when coloumn is empty' do
      xit 'returns false' do
      end
    end

    context 'when coloumn is partially filled' do
      xit 'returns false' do
      end
    end
  end
end