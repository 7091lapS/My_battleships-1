require_relative 'board'

class Player

  attr_reader :board, :ships

  def initialize(board, ship_class)
    @board = board
    @ships = [ship_class.new(2), ship_class.new(3), ship_class.new(4), ship_class.new(5) ]
  end

  def place_ships positioning_instructions
    positioning_instructions.each_with_index do |instuction, index|
      board.place(ships[index], instuction.first, instuction.last)
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

end
