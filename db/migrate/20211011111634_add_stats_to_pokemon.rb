class AddStatsToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :hp, :integer
    add_column :pokemons, :attack, :integer
    add_column :pokemons, :defense, :integer
    add_column :pokemons, :specialattack, :integer
    add_column :pokemons, :specialdefense, :integer
    add_column :pokemons, :speed, :integer
  end
end
