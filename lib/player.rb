require_relative 'board'

class Player

  attr_reader :board, :ships, :name

  def initialize(board, ship_class, name)
    @board = board
    @ships = [ship_class.new(2)]#, ship_class.new(3), ship_class.new(3), ship_class.new(4), ship_class.new(5) ]
    @name = name
  end

  def place_ships positioning_instructions
    positioning_instructions.each_with_index do |instruction, index|
      board.place(ships[index], instruction.first, instruction.last)
    end
      # extract relevant instructions
      # call board.place with the ship & the instructions
  end

  def get_shot cell
    result = board.hit_test(cell)
    if result[1] == 1
      'You\'ve hit & sunk a ship!'
    elsif result[0] == 1
      'Target hit!!'
    else
      'You missed sucka!!'
    end
  end

  def lost?
    board.lost?
  end

  def show_board player
    board.draw_the_board player.name
  end

end
