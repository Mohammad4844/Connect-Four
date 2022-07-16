require_relative 'token'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(6) { Array.new(7, Token.new) }
  end

  def insert_token(token, col)
    raise 'Coloumn is full' if coloumn_full?(col)

    i = 5
    i -= 1 until @grid[i][col].color == 'empty'
    @grid[i][col] = token
  end

  def connected_four?
    # horizontal check
    @grid.each_with_index do |row, i|
      row.each_with_index do |token, j|
        break if j  > 3

        return token if token.color != 'empty' && token == @grid[i][j + 1] &&
        token == @grid[i][j + 2] && token == @grid[i][j + 3]
      end
    end
    # vertical check
    @grid.each_with_index do |row, i|
      break if i  > 2
      row.each_with_index do |token, j|
        return token if token.color != 'empty' && token == @grid[i + 1][j] &&
          token == @grid[i + 2][j] && token == @grid[i + 3][j]
      end
    end
    # leading diagonal check
    @grid.each_with_index do |row, i|
      row.each_with_index do |token, j|
        next unless i.between?(0, 2) && j.between?(3, 6)

        return token if token.color != 'empty' && token == @grid[i + 1][j - 1] &&
          token == @grid[i + 2][j - 2] && token == @grid[i + 3][j - 3]
      end
    end
    # main diagonal check
    @grid.each_with_index do |row, i|
      row.each_with_index do |token, j|
        next unless i.between?(0, 2) && j.between?(0, 3)

        return token if token.color != 'empty' && token == @grid[i + 1][j + 1] &&
          token == @grid[i + 2][j + 2] && token == @grid[i + 3][j + 3]
      end
    end
    return nil
  end

  def full?
    @grid.all? { |row| row.all? { |token| token.color != 'empty' } }
  end

  def coloumn_full?(col)
    6.times { |i| return false if @grid[5 - i][col].color == 'empty' }
    true
  end

  def to_s
    @grid.reduce("\n\e[3m0 1 2 3 4 5 6\e[23m\n") do |result, row|  
      result + row.reduce('') do |row_result, token| 
        row_result + "#{token} " 
      end + "\n"
    end
  end
end
