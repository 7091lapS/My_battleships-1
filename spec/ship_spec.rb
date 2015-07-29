require_relative '../lib/ship'

describe Ship  do

	it 'has a location' do
		expect(subject).to respond_to :coordinates=
	end

	it 'coordinates = nil when created' do
		expect(subject.coordinates).to eq nil
	end

	it 'has a size' do
		expect(subject.size).to eq Ship::DEFAULT_SIZE
	end

  it 'increases the counter when hit' do
    subject.hit_me
    expect(subject.hit_counter).to eq 1
  end

	it '#sunk? returns true when the ship is sunk' do
		subject.size.times {subject.hit_me}
		expect( subject.sunk? ).to be true
	end

end
