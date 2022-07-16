require_relative 'lib/board'
require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/token'


Game.print_instructions
colors = ['blue', 'red']
players =[]

2.times do |i|
  print "\nPlayer #{i + 1}, enter your name: "
  player = Player.new(gets.chomp, Token.new(colors[i]))
  players << player
  puts "\n#{player.name}, your token is #{player.token.color}: #{player.token}"
end

game = Game.new(players[0], players[1])
game.play
