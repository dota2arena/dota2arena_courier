class Dota2ArenaCourier::PlayerHistory

  attr_reader :account_id, :hero_id, :player_slot

  def initialize(json)
    @json = json
  end

  def set_attributes
    @account_id = @json['account_id']
    @player_slot = @json['player_slot']
    @hero_id = @json['hero_id']
    @json = nil
    self
  end
end