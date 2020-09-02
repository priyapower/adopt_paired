class PetsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @pets = Pet.all
  end

  def index_shelter
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets.all
  end

  def show
    @pet = Pet.find(params[:id])
    app_id = PetApply.where(pet_id:@pet.id).pluck(:apply_id)
    if !@pet.status && !app_id.empty?
      @application = Apply.find(app_id.first)
    end
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
    @shelter_id = params[:shelter_id]
  end

  def create
    pet = Pet.new(pet_params)
    if
      quantity = empty_fields(params).count
      flash[:pet_fields_notice] = "Pet Creation Warning: You are missing #{pluralize(quantity, "field")}: #{empty_fields_convert}"
      redirect_to request.referer
    else
      pet.save
      redirect_to "/shelters/#{pet.shelter_id}/pets"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
    @shelter = Shelter.find(@pet.shelter_id)
  end

  def update
    @pet = Pet.find(params[:id])
    @pet.update(pet_params)
    approved_pet
    if !approved_pet.contents.empty?
      session[:approved_pet] = approved_pet.contents
      @pet.update(status:false)
    end
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    @pet = Pet.find(params[:id])
    if !@pet.status
      flash[:pet_delete_notice] = "Unable to Delete a Pet with an approved application"
      redirect_to request.referer
    else
      favorites.contents.delete(@pet.id)
      @pet.destroy
      redirect_to "/pets"
    end
  end

  def destroy_from_shelter
    @pet = Pet.find(params[:id])
    @shelter = Shelter.find(@pet.shelter_id)
    @pet.destroy
    redirect_to "/shelters/#{@shelter.id}/pets"
  end

  private
  def empty_fields(current_params)
    @pet_empty_fields = []
    current_params.each do |key, value|
      if value == ""
        @pet_empty_fields << key.capitalize
      end
    end
    @pet_empty_fields
    # This looks like a RUBY .reduce opportunity for creating that new array
  end

  def empty_fields_convert
    empty_fields_string = String.new
    @pet_empty_fields.each do |field|
      empty_fields_string += field + ", "
    end
    empty_fields_string = empty_fields_string[0..-3].gsub("_", " ")
    empty_fields_string
  end

  def pet_params
    params.permit(:image, :name, :approximate_age, :sex, :description, :shelter_id)
  end
end
