require 'spec_helper'

describe Dota2ArenaCourier::MatchHistory do
  let(:json){JSON_HISTORY}
  subject(:match){Dota2ArenaCourier::MatchHistory.new(json['result']['matches'][0]).set_attributes}

  describe 'match' do
    it 'has attributes' do
      expect(match.start_time).to eq 1416311339
      expect(match.match_id).to eq 1033253944
      expect(match.lobby_type).to eq 0
    end
  end
end