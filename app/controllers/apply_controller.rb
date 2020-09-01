class ApplyController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @pet = Pet.find(params[:id])
    if PetApply.where(pet_id:@pet.id).empty?
      flash[:apply_not_found] = "There are no applications in for this pet yet"
      redirect_to "/pets/#{@pet.id}"
    else
      @app_ids = PetApply.where(pet_id:@pet.id).pluck(:apply_id)
    end
  end

  def new
  end

  def show
    @application = Apply.find(params[:id])
    @app_pet_ids = PetApply.where(apply_id:@application.id).pluck(:pet_id)
  end


  def create
    pet_ids = session[:apply_pets]
    if pet_ids.nil?
      flash[:apply_notice] = "Application not created, please select and save 1 or more pets first (see top of page)"
      render :new
    elsif
      user = Apply.new(apply_params)
      pet_ids.each do |id|
        pet = Pet.find(id)
        PetApply.create({pet: pet, apply: user})
      end

      if user.save
        flash[:apply_complete] = "Your application has gone through for #{pluralize(pet_ids.count, "pet")}"
        pet_ids.each do |pet_id|
          favorites.contents.delete(pet_id.to_i)
        end
        applied_pets
        redirect_to "/favorites"
      else
        flash[:apply_failure] = "Your application is missing one or more elements. Pleae complete all fields before submitting your application"
        render :new
      end
    end
  end

  def update_chosen_pets
    if session[:apply_pets].nil?
      session[:apply_pets] = params[:favorited_pets]
    else
      session[:apply_pets] << params[:favorited_pets].first
    end
    flash[:apply_pets_notice] = "You have saved pet(s) to your application"
    redirect_to request.referer
  end

  private
  def apply_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
