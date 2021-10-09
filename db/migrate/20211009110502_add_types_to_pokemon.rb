class AddTypesToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :type_one, :string
    add_column :pokemons, :type_two, :string
  end
end
