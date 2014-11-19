class Dota2ArenaCourier::RoundRobinApi
  def initialize(api_keys = [])
    @api_keys = api_keys
    @size = api_keys.size
    @index = 0
  end

  def give_key
    key = @api_keys[@index]
    if @size - 1 == @index
      @index = 0
    else
      @index += 1
    end
    key
  end
end