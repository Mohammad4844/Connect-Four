class Game
  def initialize(player1, player2, board = Board.new)
    @players = [player1, player2]
    @board = board
  end

  def play
  end

  def turn_order
  end

  def player_input
  end

  def verify_input
  end

  def game_over?
  end

  def switch_player
  end
  
  def print_instructions
  end
end
