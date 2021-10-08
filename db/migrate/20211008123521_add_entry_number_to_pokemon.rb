class AddEntryNumberToPokemon < ActiveRecord::Migration[6.1]
  def change
    add_column :pokemons, :entry_no, :string
  end
end
