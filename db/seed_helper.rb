require 'open-uri'
require 'json'

def pokeapi_call(url)
  # Pull JSON file from pokeAPI url given
  serialized = URI.open(url).read
  JSON.parse(serialized)
end

def normalize_number(number)
  # return number as 3 digits long. eg: 1 --> 001 || 94 --> 094.
  if number.to_s.length == 1
    "00" + number.to_s
  elsif number.to_s.length == 2
    "0" + number.to_s
  else
    number.to_s
  end
end

def pokemon_get_types(pokemon_entry)
  # Return 1/2 types from pokemon_entry JSON
  pokemon_entry['types'].map { |type| type['type']['name'] }
end

def pokemon_get_base_stats(pokemon_entry)
  # Return 6 base stats from pokemon_entry JSON
  base_stats = {}
  pokemon_entry['stats'].each do |stat|
    base_stats[stat['stat']['name']] = stat['base_stat']
  end
  base_stats
end

def pokemon_get_description(pokemon_species_entry)
  # Return pokedex description entry from species_entry JSON
  pokemon_species_entry['flavor_text_entries'].first['flavor_text']
end
