class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    @pet = Pet.find(params[:pet_id])
    @pet_id_str = @pet.id.to_s
    session[:favorite] ||= Hash.new(0)
    session[:favorite][@pet_id_str] ||= 0
    session[:favorite][@pet_id_str] = session[:favorite][@pet_id_str] + 1
    quantity = session[:favorite][@pet_id_str]
    flash[:add_favorite] = "This pet was added to My Favorites. You now have #{pluralize(quantity, "favorite")}"
      #This quantity should work, but it isn't
    redirect_to "/pets/#{@pet.id}"
  end
end
