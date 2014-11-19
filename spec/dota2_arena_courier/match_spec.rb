require 'spec_helper'

describe Dota2ArenaCourier::Match do
  let(:json){JSON_MATCH}
  subject(:match){Dota2ArenaCourier::Match.new(json['result']).set_attributes}

  describe 'match' do
    it 'has attributes' do
      expect(match.radiant_win).to be true
      expect(match.duration).to eq 1878
      expect(match.start_time).to eq 1415440273
      expect(match.match_id).to eq 1011983771
      expect(match.cluster).to eq 181
      expect(match.lobby_type).to eq 0
      expect(match.human_players).to eq 10
      expect(match.game_mode).to eq 1
    end
  end
end