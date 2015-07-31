require 'player'

describe Player do
  let(:board) { double (:board) }
  let(:ship) { double(:ship, size: 1)}
  let(:ship_class){double :ship_class, :new => ship}
  let(:subject) {described_class.new(board, ship_class, "Player1")}

  describe '#get_shot' do

    it 'returns string when get_shot hits a ship' do
      allow(board).to receive(:place)
      allow(board).to receive(:hit_test) {[1,0]}
      board.place ship, [3,3], :horizontal
      expect(subject.get_shot [3,3]).to match('Target hit!!')
    end

    it 'returns string when get_shot sinks a ship' do
      allow(board).to receive(:place)
      allow(board).to receive(:hit_test) {[1,1]}
      board.place ship, [3,3], :horizontal
      expect(subject.get_shot [3,3]).to match('You\'ve hit & sunk a ship!')
    end
  end

  describe '#place_ships' do

      it 'should call the Board#place method with correct arguments' do
          expect(board).to receive(:place).with(ship, [0,0], :horizontal)
          subject.place_ships([[[0,0], :horizontal]])
      end
  end

  describe '#lost?' do
    it 'calls the player\'s board#lost? method' do
      expect(board).to receive(:lost?)
      subject.lost?
    end

  end
end
