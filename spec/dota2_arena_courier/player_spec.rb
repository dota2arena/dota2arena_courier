require 'spec_helper'

describe Dota2ArenaCourier::Player do
  let(:json){JSON_MATCH}
  subject(:player){Dota2ArenaCourier::Player.new(json['result']['players'][0]).set_attributes}

  describe 'player' do
    it 'has attributes' do
      expect(player.account_id).to eq 202070530
      expect(player.player_slot).to eq 0
      expect(player.hero_id).to eq 89
      expect(player.items).to eq [41, 147, 48, 137, 212, 114]
      expect(player.kills).to eq 16
      expect(player.deaths).to eq 3
      expect(player.assists).to eq 7
      expect(player.leaver_status).to eq 0
      expect(player.net_worth).to eq 23081
      expect(player.last_hits).to eq 209
      expect(player.denies).to eq 7
      expect(player.xpm).to eq 717
      expect(player.gpm).to eq 735
      expect(player.level).to eq 20
      expect(player.lvl_ups).to eq [230, 259, 290, 359, 419, 476, 548, 653, 840, 930, 1014, 1309, 1310, 1468, 1599, 1744, 1841, 1917, 1953]
    end
  end
end