class FavoritesController < ApplicationController
  def update
    @pet = Pet.find(params[:pet_id])
    flash[:add_favorite] = "This pet was added to My Favorites"
    redirect_to "/pets/#{@pet.id}"
  end
end
