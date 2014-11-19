require 'gem_config'
require 'dota2_arena_courier/version'
require 'dota2_arena_courier/fetcher'
require 'dota2_arena_courier/parser'
require 'dota2_arena_courier/round_robin_api'

module Dota2ArenaCourier

  include GemConfig::Base

  with_configuration do
    has :api_keys, classes: Array, default: ['52631328E26C1399587CBB0BB1E735F6']
  end

  def self.dota2_api_key
    @robin ||= Dota2ArenaCourier::RoundRobinApi.new(configuration.api_keys)
    @robin.give_key
  end

  def self.get_matches_json(match_ids)
    fetcher = Dota2ArenaCourier::Fetcher.new
    responses = fetcher.get_matches(match_ids)

    select_responses(responses)
  end

  def self.get_matches(match_ids)
    validated = get_matches_json(match_ids)
    good = validated[:good]
    bad = validated[:bad]

    parser = Dota2ArenaCourier::Parser.new
    parsed_matches = parser.parse_matches_json(good)

    selected_matches = select_parses(parsed_matches)

    bad += selected_matches[:bad]
    {good: selected_matches[:good], bad: bad}
  end

  def self.get_player_history_json(account_id, options = {})
    fetcher = Dota2ArenaCourier::Fetcher.new
    fetcher.get_player_history(account_id, options)
  end

  def self.get_player_history(account_id, options = {})
    response = get_player_history_json(account_id, options)
    parser = Dota2ArenaCourier::Parser.new
    parser.parse_matches_history_json(response)
  end

  def self.get_player_history_full(account_id, options = {})
    response = get_player_history_json(account_id, options)
    ids = response.map{|r| r['match_id']}
    get_matches(ids)
  end

  private

  def self.select_parses(parses)
    bad = []
    good = []

    parses.each do |p|
      if p.class == Dota2ArenaCourier::Parser::ResultMatch
        good << p
      else
        bad << p
      end
    end
    {good: good, bad: bad}
  end

  def self.select_responses(responses)
    bad = []
    good = []

    responses.each do |r|
      if r.class == Hash
        good << r
      else
        bad << r
      end
    end

    {good: good, bad: bad}
  end
end
