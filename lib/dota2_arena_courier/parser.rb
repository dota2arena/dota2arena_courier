require 'json'
require 'dota2_arena_courier/match'
require 'dota2_arena_courier/match_history'
require 'dota2_arena_courier/player'
require 'dota2_arena_courier/player_history'
require 'dota2_arena_courier/team'
require 'dota2_arena_courier/team_history'
class Dota2ArenaCourier::Parser

  def parse_matches_json(matches_json)
    matches_json.map do |match_json|
        begin
          data = match_json['result']

          if data['error']
            raise Error
          end
          radiant_players = radiant_players(data['players'])
          dire_players = dire_players(data['players'])

          match = Dota2ArenaCourier::Match.new(data).set_attributes
          radiant_team = radiant_players.map{|p| Dota2ArenaCourier::Player.new(p).set_attributes}
          dire_team = dire_players.map{|p| Dota2ArenaCourier::Player.new(p).set_attributes}

          dire = Dota2ArenaCourier::Team.new(dire_team, match.radiant_win).set_attributes
          radiant = Dota2ArenaCourier::Team.new(radiant_team, match.radiant_win).set_attributes

          ResultMatch.new(match, radiant, dire)
        rescue
          ParseError.new(match_json)
        end
    end
  end

  def parse_matches_history_json(matches)

    matches.map do |m|
      begin
        match = Dota2ArenaCourier::MatchHistory.new(m).set_attributes
        radiant_players = radiant_players(m['players'])
        dire_players = dire_players(m['players'])

        radiant_team = radiant_players.map{|p| Dota2ArenaCourier::PlayerHistory.new(p).set_attributes}
        dire_team = dire_players.map{|p| Dota2ArenaCourier::PlayerHistory.new(p).set_attributes}
        radiant = Dota2ArenaCourier::TeamHistory.new(radiant_team)
        dire = Dota2ArenaCourier::TeamHistory.new(dire_team)
        ResultMatch.new(match, radiant, dire)
      rescue
        ParseError.new(m)
      end
    end
  end

  def radiant_players(players)
    players.select{|p| p['player_slot'] < 128}
  end

  def dire_players(players)
    players.select{|p| p['player_slot'] >= 128}
  end

  class ParseError
    attr_reader :json
    def initialize(json)
      @json = json
    end
  end

  class ResultMatch
    attr_reader :match, :radiant, :dire
    def initialize(match, radiant, dire)
      @match = match
      @radiant = radiant
      @dire = dire
    end
  end
end