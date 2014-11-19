require 'spec_helper'

describe Dota2ArenaCourier::RoundRobinApi do
  subject(:robin){Dota2ArenaCourier::RoundRobinApi.new(['1234', '000', 'xxx'])}

  it 'returns 000' do
    robin.give_key
    robin.give_key
    robin.give_key
    robin.give_key
    expect(robin.give_key).to eq '000'
  end
end