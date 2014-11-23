require 'spec_helper'

describe Dota2ArenaCourier do
  subject(:parser){Dota2ArenaCourier::Parser.new}
  describe '#parse_matches_json' do
    let(:json){JSON_MATCH}

    describe 'single match' do
      it 'has a match' do
        result = parser.parse_matches_json([json])

        expect(result[0].match.match_id).to eq 1011983771
      end

      it 'has a radiant team' do
        result = parser.parse_matches_json([json])

        expect(result[0].radiant.win).to be true
        expect(result[0].radiant.players.size).to eq 5
      end

      it 'has a dire team' do
        result = parser.parse_matches_json([json])

        expect(result[0].dire.win).to be false
        expect(result[0].dire.players.size).to eq 5
      end

      it 'dire team has kills' do
        result = parser.parse_matches_json([json])
        expect(result[0].dire.kills).to eq 27
      end
    end
  end
  describe 'history' do
    let(:matches){JSON_HISTORY['result']['matches']}
    subject(:result){parser.parse_matches_history_json(matches)}
    it 'has 100 matches' do
      expect(result.size).to eq 100
    end

    it 'has correct match id' do
      expect(result[0].match.match_id).to eq 1033253944
    end

    it 'has good player' do
      expect(result[0].radiant.players[0].hero_id).to eq 37
    end

    it 'has radiant' do
      expect(result[0].radiant.players.size).to eq 5
    end

    it 'has dire' do
      expect(result[0].dire.players.size).to eq 5
    end
  end
end