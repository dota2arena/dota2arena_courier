require 'typhoeus'
require 'json'
class Dota2ArenaCourier::Fetcher

  def get_matches(match_ids)
    urls = match_ids.map { |id| match_url(id)}
    responses = fetch(urls, 50)
    responses.map do |r|
      begin
        JSON.parse(r.response.body)
      rescue
        id = extract_match_id_url(r.response.effective_url)
        FetchError.new(id)
      end
    end
  end

  def get_player_history(account_id, options = {})
    limit = options[:limit] || 100
    limit = Float::INFINITY if options[:all]
    recursive_parse_history(account_id, {limit: limit})
  end

  def get_player_history_full(account_id, options = {})
    history = get_player_history(account_id, options)

    ids = history.map{|h| h['match_id']}

    get_matches(ids)
  end

  def fetch(urls, concurrency = 1)
    hydra = Typhoeus::Hydra.new(max_concurrency: concurrency)
    requests = urls.map do |u|
      request = Typhoeus::Request.new(u, followlocation: true)
      hydra.queue(request)
      request
    end
    hydra.run
    requests
  end

  def recursive_parse_history(account_id, options = {})
    matches_json = options[:matches_json] || []
    limit = options[:limit] || 100
    last_match = options[:last_match]
    remaining = options[:remaining] || 100

    if limit > 0 && remaining > 0
      begin
        url = player_history_url(account_id, {last_match: last_match, limit: limit})
        response = fetch([url])[0]
        json = JSON.parse(response.response.body)
        new_remaining = json['result']['results_remaining']
        new_last_match = json['result']['matches'][json['result']['num_results'] - 1]['match_id']
        matches_jzon = json['result']['matches']
        if last_match
          matches_jzon.shift
        end
        if limit > 100
          new_limit = limit - 99
          matches_json += matches_jzon
        else
          matches_json += matches_jzon[0 .. limit - 1]
          new_limit = 0
        end

        if new_remaining > 0 && new_limit > 0
          recursive_parse_history(account_id, {limit: new_limit, remaining: new_remaining,
                                               last_match: new_last_match, matches_json: matches_json})
        else
          return matches_json
        end
      rescue
         matches_json
      end
    end
  end

  def player_history_url(account_id, options = {})
    last_match = options[:last_match]
    limit = options[:limit]
    url = "http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?key=#{Dota2ArenaCourier.dota2_api_key}&account_id=#{account_id}"

    if last_match
      url += "&start_at_match_id=#{last_match}"
    end

    if limit && limit < 100
      url += "&matches_requested=#{limit}"
    end
    url
  end

  class FetchError
    attr_reader :id
    def initialize(id)
      @id = id
    end
  end

  def match_url(match_id)
    'http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/' +
        "?key=#{Dota2ArenaCourier.dota2_api_key}" +
        "&match_id=#{match_id}"
  end

  def extract_match_id_url(url)
    first_str = /&match_id=\d+/.match(url).to_s
    /\d+/.match(first_str).to_s.to_i
  end

end
