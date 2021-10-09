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

def pokemon_api_call(id)
  pokemon_url = "https://pokeapi.co/api/v2/pokemon/#{id}"
  pokemon_serialized = URI.open(pokemon_url).read
  pokemon_entry = JSON.parse(pokemon_serialized)
  # for now this only returns pokemon types. to be expanded
  pokemon_entry['types'].map { |type| type['type']['name'] }
end

p 'Seeding database...'
sleep(1)
pokeapi_call.each_with_index do |pokemon, index|
  pokemon_name = pokemon['pokemon_species']['name']
  Pokemon.create(name: pokemon_name.capitalize, entry_no: normalize_number(pokemon['entry_number']))
  p "No. #{index+1} - #{pokemon_name.capitalize} added!"
end
sleep(1)
p 'Adding specific pokemon information!'
all_pokemon = Pokemon.all
all_pokemon.each do |pokemon|
  types = pokemon_api_call(pokemon.id)
  pokemon.update(type_one: types[0],
                 type_two: types[1])
  p "#{pokemon.name} information added!"
end

p "Seeded #{Pokemon.count} pokemon!"
sleep(1)
p 'Action complete'
