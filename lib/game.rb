require_relative 'player'
require_relative 'coordinate_generator'

class Game
  include CoordinateGenerator

  attr_reader :player1, :player2
  
  def initialize playerClass
    @player1 = playerClass.new(Board.new, Ship)
    @player2 = playerClass.new(Board.new, Ship)
  end

  def initiate_placing(player, coordinates)
    player.place_ships(coordinates)
  end

  def get_target
    cell_tester
  end

  def fire_at( player, cell )
    player.get_shot cell
  end

  def take_turn opponent
    target = get_target
    fire_at opponent , target
  end

  # ----------------------------
  # Junkyard
  # ----------------------------
  def cell_tester
    produce_cell
  end

end
