require_relative 'player'
require_relative 'user_input'
require 'terminal-table'

class Game
  include UserInput

  attr_reader :player1, :player2, :players

  def initialize(playerClass=Player)
    @player1 = playerClass.new(Board.new, Ship, "Player1")
    @player2 = playerClass.new(Board.new, Ship, "Player2")
    @players = [player1, player2]
  end

  def initiate_placing(player, coordinates)
    player.place_ships(coordinates)
  end

  def get_target
    request_cell
  end

  def fire_at( player, cell )
    player.get_shot cell
  end

  def player_switch
    players.rotate!
  end

  def take_turn
    if not (players[0].lost? || players[1].lost?)
      puts ""
      puts "---------------------"
      puts "#{players[1].name}: Take 'em down!"
      puts "---------------------"
      puts "#{players[0].name}, #{players[1].name}"
      target = get_target # calls user input module
      target = target.split(",").map(&:to_i)
      result = fire_at players[0] , target
      players[0].show_board players[1]
      player_switch
      puts ""
      puts result
      puts "Please hit return when you are ready to hand over"
      gets
      system 'clear'
      take_turn
    else
      end_game
    end
  end

  def end_game
    if player1.lost?
      return "Congratulations Player2: you are victorious!"
    elsif player2.lost?
      return "Congratulations Player1: you are victorious!"
    end
  end

end
