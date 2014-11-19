require 'spec_helper'

describe Dota2ArenaCourier::PlayerHistory do
  let(:json){JSON_HISTORY}
  subject(:player){Dota2ArenaCourier::PlayerHistory.new(json['result']['matches'][0]['players'][0]).set_attributes}

  describe 'player' do
    it 'has attributes' do
      expect(player.account_id).to eq 105382029
      expect(player.player_slot).to eq 0
      expect(player.hero_id).to eq 37
    end
  end
end