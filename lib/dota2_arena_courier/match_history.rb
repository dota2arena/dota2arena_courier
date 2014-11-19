class Dota2ArenaCourier::MatchHistory

  attr_reader :start_time, :match_id, :lobby_type

  def initialize(json)
    @json = json
  end

  def set_attributes
    @start_time = @json['start_time']
    @match_id = @json['match_id']
    @lobby_type = @json['lobby_type']
    @json = nil
    self
  end
end