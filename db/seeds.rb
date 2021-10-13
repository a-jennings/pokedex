require_relative 'seed_helper'

puts 'Seeding Pokemon into database...'
national_dex = pokeapi_call('https://pokeapi.co/api/v2/pokedex/national')['pokemon_entries']
national_dex.each do |pokemon|
  pokemon_name = pokemon['pokemon_species']['name']
  entry_no = normalize_number(pokemon['entry_number'])
  Pokemon.create(name: pokemon_name, entry_no: entry_no)
  puts "No. #{entry_no} - #{pokemon_name.capitalize} added!"
end
puts 'Adding specific pokemon information...'
Pokemon.all.each do |pokemon|
  pokemon_entry = pokeapi_call("https://pokeapi.co/api/v2/pokemon/#{pokemon.id}")
  pokemon_species_entry = pokeapi_call("https://pokeapi.co/api/v2/pokemon-species/#{pokemon.id}")
  types = pokemon_get_types(pokemon_entry)
  base_stats = pokemon_get_base_stats(pokemon_entry)
  description = pokemon_get_description(pokemon_species_entry).tr("\n \f", ' ')
  pokemon.update(type_one: types[0],
                 type_two: types[1],
                 hp: base_stats['hp'],
                 attack: base_stats['attack'],
                 defense: base_stats['defense'],
                 specialattack: base_stats['special-attack'],
                 specialdefense: base_stats['special-defense'],
                 speed: base_stats['speed'],
                 description: description,
                 height: pokemon_entry['height'],
                 weight: pokemon_entry['weight'])
  puts "(#{pokemon.id}/#{Pokemon.count}) - #{pokemon.name.capitalize} information added!"
end

puts "Seeded #{Pokemon.count} pokemon!"
