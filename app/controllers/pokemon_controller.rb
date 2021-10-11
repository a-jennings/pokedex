class PokemonController < ApplicationController
  def index
    @pokemon = Pokemon.all.sort
  end
  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
