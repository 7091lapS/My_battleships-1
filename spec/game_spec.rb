require 'game'

describe Game do
  let(:subject) {described_class.new(playerClass)}
  let(:playerClass) { double :playerClass, :new => player }
  let(:player) { double (:player), name: "Player" }
  let(:player1) { double (:player), name: "Player1" }
  let(:player2) { double (:player), name: "Player2" }
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
      allow(subject).to receive(:request_cell) { cell }
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
      cell = "0,0"
      allow(subject).to receive(:request_cell) { cell }
      allow(player).to receive(:get_shot)
      allow(player).to receive(:lost?) { false }
      expect(subject).to receive(:fire_at).with(player, [0,0])
      subject.take_turn
    end

    it 'should call #end_game if either player has lost' do
      allow(player).to receive(:lost?) { true }
      expect(subject).to receive(:end_game)
      subject.take_turn
    end
  end

  describe '#player_switch' do
    it 'rotates the players inside the @players array' do
      expect(subject.player_switch).to match_array([subject.player2, subject.player1])
    end
  end

  describe '#end_game' do
    it 'correctly reports the winning player: Player2' do
      allow( player1 ).to receive( :lost? ).and_return true
      allow( player2 ).to receive( :lost? ).and_return false
      expect(subject.end_game).to eq("Congratulations Player2: you are victorious!")
    end

    it 'correctly reports the winning player: Player1' do
      allow( player1 ).to receive( :lost? ).and_return false
      allow( player2 ).to receive( :lost? ).and_return true
      expect(subject.end_game).to eq("Congratulations Player1: you are victorious!")
    end
  end

end
