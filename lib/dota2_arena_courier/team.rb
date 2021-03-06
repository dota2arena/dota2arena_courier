class Dota2ArenaCourier::Team

  attr_reader :win, :players, :kills, :deaths, :assists, :xpm, :gpm, :net_worth, :last_hits, :denies, :lvl_ups, :level

  def initialize(players, radiant_win)
    @players = players
    @win = check_if_win(radiant_win)
  end

  def set_attributes
    kills = 0; deaths = 0; assists = 0
    xpm = 0; gpm = 0; net_worth = 0
    last_hits = 0; denies = 0; level = 0
    lvl_ups = []

    @players.each do |p|
      kills += p.kills; deaths += p.deaths; assists += p.assists
      xpm += p.xpm; gpm += p.gpm; net_worth += p.net_worth
      last_hits += p.last_hits; denies += p.denies
      level += p.level
      add_levels(lvl_ups, player_convert_levels(p.lvl_ups))
    end

    @kills = kills; @deaths = deaths; @assists = assists
    @xpm = xpm; @gpm = gpm; @net_worth = net_worth; @last_hits = last_hits
    @denies = denies; @lvl_ups = lvl_ups; @level = level
    @json = nil
    self
  end

  def player_convert_levels(levels)
    new_levels = []
    target_level = 3
    len = levels.size
    levels[target_level - 1 .. len - 1].each_with_index { |time, i| new_levels << time if i % target_level == 0 }

    new_levels
  end

  def add_levels(current_levels, new_levels)
    new_levels.each_with_index do |l, index|
      if current_levels[index].nil?
        current_levels[index] = {players: 1, sum: l}
      else
        current_levels[index][:players] += 1
        current_levels[index][:sum] += l
      end
    end
  end

  def check_if_win(radiant_win)
    if radiant_win && @players[0].player_slot < 128 || !radiant_win && @players[0].player_slot >= 128
      true
    else
      false
    end
  end
end