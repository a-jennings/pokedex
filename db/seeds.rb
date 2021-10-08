require 'open-uri'
require 'json'

def pokeapi_call
  national_pokedex_url = 'https://pokeapi.co/api/v2/pokedex/national'
  pokedex_serialized = URI.open(national_pokedex_url).read
  pokedex_entry = JSON.parse(pokedex_serialized)
  pokedex_entry['pokemon_entries']
end

pokeapi_call.each do |pokemon|
  pokemon_name = pokemon['pokemon_species']['name']
  p "Seeding #{pokemon_name}"
  Pokemon.create(name: pokemon_name.capitalize)
end

p "Seeded #{Pokemon.count} pokemon"
