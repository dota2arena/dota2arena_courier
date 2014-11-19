require 'spec_helper'

describe Dota2ArenaCourier::TeamHistory do

  let(:json){JSON_HISTORY}
  subject(:players){json['result']['matches'][0]['players'][0..4].map{|p| Dota2ArenaCourier::PlayerHistory.new(p).set_attributes}}

  subject(:team){Dota2ArenaCourier::TeamHistory.new(players)}

  describe 'team' do
    it 'has 5 players' do
      expect(team.players.size).to eq 5
    end
  end
end