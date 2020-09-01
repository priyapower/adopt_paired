class ApplicationController < ActionController::Base
  helper_method :favorites, :applied_pets
  def favorites
    @favorites ||= Favorite.new(session[:favorite])
  end

  def applied_pets
    PetApply.pluck(:pet_id)
  end
end
