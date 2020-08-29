class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:pet_id])
    @favorite = Favorite.new(session[:favorite])
    @favorite.add_pet(pet.id)
    session[:favorite] = @favorite.contents
    quantity = @favorite.count
    flash[:add_favorite] = "This pet was added to My Favorites. You now have #{pluralize(quantity, "favorite")}"
    redirect_to "/pets/#{pet.id}"
  end
end
