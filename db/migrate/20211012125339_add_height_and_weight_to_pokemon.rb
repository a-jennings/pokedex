class AddHeightAndWeightToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :height, :integer
    add_column :pokemons, :weight, :integer
  end
end
