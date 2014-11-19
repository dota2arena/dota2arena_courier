class Dota2ArenaCourier::Match

  attr_reader :radiant_win, :duration, :start_time, :match_id, :cluster, :lobby_type, :human_players, :game_mode

  def initialize(json)
    @json = json
  end

  def set_attributes
    @radiant_win = @json['radiant_win']
    @duration = @json['duration']
    @start_time = @json['start_time']
    @match_id = @json['match_id']
    @cluster = @json['cluster']
    @lobby_type = @json['lobby_type']
    @human_players = @json['human_players']
    @game_mode = @json['game_mode']
    @json = nil
    self
  end
end