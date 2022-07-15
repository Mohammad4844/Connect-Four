require_relative 'player'
require_relative 'token'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(6) { Array.new(7, Token.new) }
  end

  def insert_token(token, col)
  end

  def connected_four?
  end

  def full?
  end

  def coloumn_full?
  end

  def to_s
    @grid.reduce('') do |result, row|
      result + row.reduce('') do |row_result, token| 
        row_result + "#{token} " 
      end + "\n"
    end 
  end
end
