class Ship

	DEFAULT_SIZE = 2

	attr_reader :size, :hit_counter
	attr_accessor :coordinates

	def initialize size = DEFAULT_SIZE
  @coordinates = nil
  @size = size
  @hit_counter = 0
	end

  def hit_me
    @hit_counter += 1
  end

	def sunk?
		hit_counter == size
	end

end
