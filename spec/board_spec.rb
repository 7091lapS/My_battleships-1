require 'board'

describe Board do

	let(:ship) { double (:ship), size: 3}

	describe '#place' do
		it 'place function exists' do
			expect(subject).to respond_to :place
		end

		it 'takes an argument' do
			expect(subject).to respond_to(:place).with(3).argument
		end

		it 'does not accept negative x co-ordinates' do
			expect{ subject.place(ship, [-1, 3], :horizontal) }.to raise_error "Can't use negatve co-ordinates!"
		end

		it 'does not accept negative y co-ordinates' do
			expect{ subject.place(ship, [1, -3], :horizontal) }.to raise_error "Can't use negatve co-ordinates!"
		end

		it 'updates the ship_hash with the ship and its coordinates' do
			subject.place ship, [0, 0], :horizontal
			expect(subject.ship_hash.values[0]).to be ship
		end

		context '#test_boundary and overlap' do
			let(:ship) { double (:ship), size: 3}
			it 'does not accept x co-ordinates out of boundary' do
				bound = subject.boundary
				expect{ subject.place( ship, [bound-1,2], :horizontal) }.to raise_error "Co-ordinates must not go off the board!"
			end

			it 'does not overlap' do
				subject.place ship, [1,1], :vertical
				expect{subject.place ship, [1,1], :vertical}.to raise_error"Boats cannot overlap"
			end
	  end
  end

describe '#ext_coord' do
	context 'size = 2' do
  let(:ship) { double (:ship), size: 2}
		it 'calculates the coordinates from cell' do
		expect(subject.ext_coord(ship, [0,0], :horizontal)).to match_array([[0,0],[1,0]])
		end

		it 'calculates the coordinates from cell' do
		expect(subject.ext_coord(ship, [0,0], :vertical)).to match_array([[0,0],[0,1]])
		end
	end
end

describe '#hit_test' do
	it 'returns true when target cell belongs to @ship_positions' do
		cell = [3,3]
		allow( ship ).to receive( :hit_me )
		allow( ship ).to receive( :sunk? )
		subject.place ship, cell, :horizontal
		result = subject.hit_test(cell)
		expect(result[0]).to be 1
	end

	it 'add the shot to history_hash[:hits] when player fires & hits' do
		cell = [3,3]
		allow( ship ).to receive( :hit_me )
		allow( ship ).to receive( :sunk? )
		subject.place ship, cell, :horizontal
		subject.hit_test cell
		subject.hit_test [8,8]
		expect( subject.history_hash[:hits].length ).to eq 1
	end

	it 'add the shot to history_hash[:misses] when player fires & misses' do
		cell = [3,3]
		allow( ship ).to receive( :hit_me )
		allow( ship ).to receive( :sunk? )
		subject.place ship, cell, :horizontal
		subject.hit_test cell
		subject.hit_test [8,8]
		expect( subject.history_hash[:misses].length ).to eq 1
	end

	it '#hit_me called on correct ship' do
		cell = [3,3]
		allow( ship ).to receive( :sunk? )
		subject.place ship, cell, :horizontal
		expect( ship ).to receive( :hit_me )
		subject.hit_test cell
	end
end

	describe '#lost?' do
		let(:ship) { double (:ship), size: 1 }
		let(:ship2) { double (:ship), size: 1}
		it 'returns true if all the ships have been sunk' do
			cell = [0,0]
			allow( ship ).to receive( :hit_me )
			allow( ship ).to receive( :sunk? )
			subject.place ship, cell, :horizontal
			subject.hit_test cell
			expect(subject.lost?).to be true
		end

		it 'returns false if not all the ships have been sunk' do
			cell = [0,0]
			cell2 = [1,1]
			allow( ship ).to receive( :hit_me )
			allow( ship ).to receive( :sunk? )
			subject.place ship, cell, :horizontal
			subject.place ship2, cell2, :horizontal
			subject.hit_test cell
			expect(subject.lost?).to be false
		end
	end

	# describe '#draw_the_board' do
	# 	hash = { hits: [ [0,0], [1,0] ], misses: [ [0,1], [2,1] ] }
	# 	let(:subject) {described_class.new(3)}
	# 	allow(subject).to receive(:boundary) {3}
	# 	allow(subject).to receive(:history_hash) {hash}
	# 	# expect(subject.draw_the_board).to eq([  [".",".","."],
	#  # 																					["O",".","O"],
	# 	# 																				["X","X","."]  ])
	# end

end
