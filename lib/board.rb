require_relative 'ship'

class Board

	DEFAULT_BOUNDARY = 10

	attr_reader :boundary, :ship_hash, :history_hash

	def initialize boundary = DEFAULT_BOUNDARY
		@boundary = boundary
		@ship_positions = []
		@ship_hash = { }
		@history_hash = { hits: [], misses: [] }
	end

	def place ship, cell, orientation
		test_negatives cell
		positions = ext_coord(ship, cell, orientation)
		test_overlap positions
		test_boundary positions
		@ship_positions += positions
		positions.each { |position| ship_hash[position] = ship }
	end

	def ext_coord ship, cell, orientation
		x = cell[0]
		y = cell[1]
		if orientation == :horizontal
			return (0..ship.size - 1).map{ |element| [x + element, y] }
		elsif orientation == :vertical
			return (0..ship.size - 1).map{ |element| [x, y + element] }
		end
	end

	def test_negatives cell
			fail "Can't use negatve co-ordinates!" if cell.any? {|c| c < 0}
	end

	def test_boundary extracted_coordinates
			fail "Co-ordinates must not go off the board!" if extracted_coordinates.flatten.any? {|v| v > boundary-1}
	end

	def test_overlap extracted_coordinates
		    fail "Boats cannot overlap" unless (extracted_coordinates&@ship_positions).empty?
	end

	def hit_test cell
		result = [0,0]
		if @ship_positions.include?(cell)
			result[0] = 1
			@ship_hash[cell].hit_me
			@history_hash[:hits].push(cell)
			if @ship_hash[cell].sunk?
				result[1] = 1
			end
		else
			@history_hash[:misses].push(cell)
		end
		return result
	end

	def lost?
		@ship_positions&history_hash[:hits] == @ship_positions
	end

end
