class ApplicationController < ActionController::Base
  helper_method :favorites, :applied_pets, :approved_pet
  def favorites
    @favorites ||= Favorite.new(session[:favorite])
  end

  def approved_pet
    ApprovedPet.new(params[:approved_pet])
  end

  def applied_pets
    PetApply.pluck(:pet_id)
  end
end
