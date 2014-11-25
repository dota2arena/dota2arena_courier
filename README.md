# Dota2ArenaCourier

Dota2 fetcher/parser for high volume of matches and history

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dota2_arena_courier'
```



    $ bundle
Add config to initializers
```ruby
Dota2ArenaCourier.configure do |config|
    #Round robin api key selector
    config.api_keys = ['xxx', 'yyy', 'zzz'] #Add as many keys as you want
    config.concurrency = 25 #is the default
end
```

Or install it yourself as:

    $ gem install dota2_arena_courier

## Usage

###JSON Match
```ruby
results = Dota2ArenaCourier.get_matches_json(['1234','111'])
good_json = results[:good] #Array of good responses
bad_json = results[:bad] #Array of Error objects, .id() to get the match id of bad response
```

###Parsed Match
```ruby
results = Dota2ArenaCourier.get_matches(['1234','111'])
good_matches = results[:good] #Array of good responses
bad_matches = results[:bad] #Array of Error objects, .id() to get the match id of bad response or .json() for parsisng issuses
```

###Json History
```ruby
history = Dota2ArenaCourier.get_player_history_json('account_id', {limit: 300}) #latest 300 matches
history_1 = Dota2ArenaCourier.get_player_history_json('account_id', {all: true}) #all

```

###Parsed History
```ruby
history = Dota2ArenaCourier.get_player_history('account_id', {limit: 300}) #latest 300 matches
history_1 = Dota2ArenaCourier.get_player_history('account_id', {all: true}) #all
```

###Full History matches
```ruby
history = Dota2ArenaCourier.get_player_history_full('account_id', {limit: 300}) #latest 300 matches
history_1 = Dota2ArenaCourier.get_player_history_full('account_id', {all: true}) #all

#it returns a hash, of good and bad matches like get_matches()
```


###Match attributes
```ruby
radiant_win
duration
start_time
match_id
cluster
lobby_type
human_players
game_mode
```

###Team attributes
```ruby
win
players
kills
deaths
assists
xpm
gpm
net_worth
last_hits
denies
lvl_ups # [{:players=>5, :sum=>1752}, ...] sum is the time when players reached the level
# levels selected are 3 and multiply of 3
level
```

###Player attributes
```ruby
account_id
hero_id
items #also of sylla
kills
deaths
assists
leaver_status
net_worth
last_hits
denies
gpm
xpm
level
lvl_ups #[230, 259, 290, 359, 419, 476 ... ] time when player lvl up
player_slot
```



##Tips
4-5 keys are enough