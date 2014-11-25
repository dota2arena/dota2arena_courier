class Dota2ArenaCourier::Player

  attr_reader :account_id, :hero_id, :items, :kills, :deaths, :assists, :leaver_status, :net_worth,
              :last_hits, :denies, :gpm, :xpm, :level, :lvl_ups, :player_slot

  def initialize(json)
    @json = json
  end

  def set_attributes
    @account_id = @json['account_id']
    @player_slot = @json['player_slot']
    @hero_id = @json['hero_id']
    @items = set_items(@json)
    @kills = @json['kills']
    @deaths = @json['deaths']
    @assists = @json['assists']
    @leaver_status = @json['leaver_status']
    @net_worth = @json['gold'] + @json['gold_spent']
    @last_hits = @json['last_hits']
    @denies = @json['denies']
    @gpm = @json['gold_per_min']
    @xpm = @json['xp_per_min']
    @level = @json['level']
    @lvl_ups = set_level_ups(@json)
    @json = nil
    self
  end

  def set_items(json)
    items = [json['item_0'], json['item_1'], json['item_2'], json['item_3'], json['item_4'], json['item_5']]
    if @hero_id == 80
      bear = json['additional_units'][0]
      items += [bear['item_0'], bear['item_1'], bear['item_2'], bear['item_3'], bear['item_4'], bear['item_5']]
    end
    items
  end

  def set_level_ups(json)
    abilities = json['ability_upgrades']
    abilities.map { |a| a['time']}
  end
end