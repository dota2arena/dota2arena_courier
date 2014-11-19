require 'dota2_arena_courier'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end

JSON_MATCH = JSON.parse(File.read('spec/mocks/json/match_example.json'))
JSON_HISTORY = JSON.parse(File.read('spec/mocks/json/history_example.json'))