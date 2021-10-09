class PokemonController < ApplicationController
  def index
    @pokemon = Pokemon.all.sort
  end
end
