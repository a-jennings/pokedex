require 'open-uri'
require 'json'

def pokeapi_call
  national_pokedex_url = 'https://pokeapi.co/api/v2/pokedex/national'
  pokedex_serialized = URI.open(national_pokedex_url).read
  pokedex_entry = JSON.parse(pokedex_serialized)
  pokedex_entry['pokemon_entries']
end

def normalize_number(number)
  # force number to be 3 digits long. eg: 1 --> 001 || 94 --> 094.
  # return number as a string for finding images
  if number.to_s.length == 1
    "00" + number.to_s
  elsif number.to_s.length == 2
    "0" + number.to_s
  else
    number.to_s
  end
end

p 'Seeding database...'

pokeapi_call.each do |pokemon|
  pokemon_name = pokemon['pokemon_species']['name']
  Pokemon.create(name: pokemon_name.capitalize, entry_no: normalize_number(pokemon['entry_number']))
end

p "Seeded #{Pokemon.count} pokemon"
