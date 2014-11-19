require 'spec_helper'

describe Dota2ArenaCourier::Team do
  let(:json){JSON_MATCH}
  let(:players) do
    json['result']['players'][0..4].map{|p| Dota2ArenaCourier::Player.new(p).set_attributes}
  end
  let(:match){Dota2ArenaCourier::Match.new(json['result']).set_attributes}

  subject(:team){Dota2ArenaCourier::Team.new(players, match.radiant_win).set_attributes}

  describe 'team' do
    it 'has attributes' do
      expect(team.kills).to eq 34
      expect(team.deaths).to eq 27
      expect(team.assists).to eq 58
      expect(team.xpm).to eq 2512
      expect(team.gpm).to eq 2271
      expect(team.net_worth).to eq 69434
      expect(team.last_hits).to eq 486
      expect(team.denies).to eq 23
      expect(team.lvl_ups).to eq [{:players=>5, :sum=>1752}, {:players=>5, :sum=>3245}, {:players=>5, :sum=>5427}, {:players=>5, :sum=>7694}, {:players=>4, :sum=>7273}, {:players=>2, :sum=>3902}]
      expect(team.level).to eq 82
      expect(team.win).to be true
    end
  end
end