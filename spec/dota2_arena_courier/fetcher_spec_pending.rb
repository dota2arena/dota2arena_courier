require 'spec_helper'

describe Dota2ArenaCourier::Fetcher do
  subject(:fetcher){Dota2ArenaCourier::Fetcher.new}

  describe '#extract_match_id_url' do
   it 'returns id' do
     url = 'https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?key=52631328E26C1399587CBB0BB1E735F6&match_id=99111114687'
     result = fetcher.extract_match_id_url(url)
     expect(result).to eq 99111114687
   end
  end

  describe '#fetch' do
    it 'returns 40 responses' do
      urls = ['www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro',
              'www.google.ro', 'www.google.ro', 'www.google.ro', 'www.google.ro']
      result = fetcher.fetch(urls, 200)
      expect(result.size).to eq 40
    end
  end

  describe '#get_matches' do
    it 'returns 3 matches as json' do
      match_ids = ['1034961808', '1034961808', '1034961808']
      result = fetcher.get_matches(match_ids)
      expect(result.size).to eq 3
    end
  end

  describe '#recursive_parse_history' do
    it 'returns first 100 matches' do
      account_id = 105382029
      result = fetcher.recursive_parse_history(account_id, {limit: 100})
      expect(result.size).to eq 100
    end

    it 'returns first 200 matches' do
      account_id = 105382029
      result = fetcher.recursive_parse_history(account_id, {limit: 200})
      expect(result.size).to eq 200
    end

    it 'returns first 240 matches' do
      account_id = 105382029
      result = fetcher.recursive_parse_history(account_id, {limit: 240})
      expect(result.size).to eq 240
    end

    it 'returns 0 matches' do
      account_id = 1
      result = fetcher.recursive_parse_history(account_id, {limit: 240})
      puts result.last
      expect(result.size).to eq 0
    end
  end

  describe '#get_player_history' do
    it 'gets full history' do
      account_id = 105382029
      result = fetcher.get_player_history(account_id, {all: true})
      expect(result.size).to eq 500
    end
  end

  describe '#get_player_history_full' do
    it 'gets full history parsed' do
      account_id = 105382029
      result = fetcher.get_player_history_full(account_id, {all: true})
      expect(result.size).to eq 500
    end
  end
end