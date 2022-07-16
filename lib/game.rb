require_relative '../lib/board'

class Game
  def initialize(player1, player2, board = Board.new)
    @players = [player1, player2]
    @board = board
  end

  def play
    loop do
      puts @board
      turn_order

      result = game_over?
      break end_game_with(result) if result
    end
  end

  def turn_order
    curr_player = switch_player
    @board.insert_token(curr_player.token, player_input(curr_player))
  end

  def player_input(player)
    print "\n\e[1m#{@players[0].name}\e[22m, enter a coloumn to place your token: "
    loop do
      input = verify_input(gets.chomp)
      return input if input

      print 'Invalid input! Please enter a col no (0-6):'
    end
  end

  def verify_input(input)
    if input.match?(/^\d$/)
      num = input.to_i
      return num if num.between?(0, 6) && !@board.coloumn_full?(num)
    end
  end

  def game_over?
    winning_token = @board.connected_four?
    return winning_token if winning_token
    return true if @board.full?
    false
  end

  def switch_player
    @players.rotate!(1)
    @players[0]
  end

  def end_game_with(result)
    puts @board
    if result.instance_of? Token
      puts "\nCongratulations! \e[1m#{@players[0].name}\e[22m won!"
    else result
      puts "\nYou both tied :("
    end
    puts ''
  end
  
  def self.print_instructions
    puts <<~INSTRUCTIONS 
      
      \e[1mWelcome to Connect 4\e[22m

      This is a 2 player game, played on a 7x6 board, where each player inserts tokens. 
      #{Board.new}
      The goal for the player is to connect 4 tokens side-by-side, either horizontally, verically or diagonally.
    INSTRUCTIONS

  end
end
