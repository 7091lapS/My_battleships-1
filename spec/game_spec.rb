require_relative '../lib/game'

describe Game do
  let(:subject) {described_class.new(playerClass)}
  let(:playerClass) { double :playerClass, :new => player }
  let(:player) { double (:player) }
  let(:player2) { double (:player) }
  let(:positioning_instructions) { double :positioning_instructions }
  let(:cell) { double (:cell) }

  describe '#allocate_ships' do
    it 'should allocate ships according to the given starting point' do
        allow(player).to receive(:place_ships)
        expect(player).to receive(:place_ships).with(positioning_instructions)
        subject.initiate_placing(player, positioning_instructions)
    end
  end

  describe '#get_target' do
    it 'should return the cell provided by the player' do
      cell = [0,0]
      allow(subject).to receive(:cell_tester) { cell }
      expect(subject.get_target).to match_array( cell )
    end
  end

  describe '#fire_at' do
    it 'should call #get_shot on the selected player' do
      allow(player).to receive(:get_shot)
      expect(player).to receive(:get_shot).with(cell)
      subject.fire_at(player, cell)
    end
  end

  describe '#take_turn' do
    it 'should pass cell from get_target to fire' do
      cell = [0,0]
      allow(subject).to receive(:cell_tester) { cell }
      allow(player).to receive(:get_shot)
      expect(subject).to receive(:fire_at).with(player, cell)
      subject.take_turn player
    end
  end

end
