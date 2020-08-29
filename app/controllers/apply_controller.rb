class ApplyController < ApplicationController

  def new
    favorites
  end

  def create
    user = Apply.new(apply_params)
    # binding.pry
  end

  def update_chosen_pets
    chosen_pet_ids = params[:pet_ids]
    redirect_to request.referer
  end

  private

  def apply_params
    params.permit(:name, :address, :city, :state,
                  :zip, :phone_number, :description)
  end
end
