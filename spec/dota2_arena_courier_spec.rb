require 'spec_helper'
require 'json'
describe Dota2ArenaCourier do
  describe '#get_matches_json' do
    it 'returns 2 good reponses' do
      ids = [1035914338, 1035912482]

      result = Dota2ArenaCourier.get_matches_json(ids)

      expect(result[:good].size).to eq 2
      expect(result[:bad].size).to eq 0
    end
  end

  describe '#get_matches' do
    it 'retruns 2 parsed matches' do
      ids = [1035914338, 1035912482]

      result = Dota2ArenaCourier.get_matches(ids)

      expect(result[:good].size).to eq 2
      expect(result[:bad].size).to eq 0
    end
  end

  describe '#get_player_history_json' do
    it 'returns 100 matches' do
      account_id = 105382029
      result = Dota2ArenaCourier.get_player_history_json(account_id, {limit: 100})
      expect(result.size).to eq 100
    end
  end

  describe '#get_player_history' do
    it 'returns 100 matches parsed' do
      account_id = 105382029
      result = Dota2ArenaCourier.get_player_history(account_id, {limit: 100})
      expect(result.size).to eq 100
    end
  end

  describe 'get_player_history_full' do
    it 'returns 240 parsed matches from history' do
      account_id = 105382029
      result = Dota2ArenaCourier.get_player_history_full(account_id, {limit: 240})
      expect(result[:good].size).to be > 200
      expect(result[:bad].size).to be < 200
    end
  end
end