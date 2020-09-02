class SheltersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
    @pet_counter = @shelter.pets.count
    @average_rating = @reviews.average(:rating)
    @shelter_applications = Array.new
    @shelter.pets.each do |pet|
      @shelter_applications << PetApply.where(pet_id: pet.id).pluck(:apply_id)
    end
    @shelter_applications.flatten!
    @numb_of_applications = @shelter_applications.count
  end


  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      quantity = empty_fields(params).count
      flash[:shelter_fields_notice] = "Shelter Creation Warning: You are missing #{pluralize(quantity, "field")}: #{empty_fields_convert}"
      redirect_to request.referer
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    if @shelter.update(shelter_params)
      redirect_to "/shelters/#{@shelter.id}"
    else
      quantity = empty_fields(params).count
      flash[:shelter_edit_fields_notice] = "Shelter Edit Warning: You are missing #{pluralize(quantity, "field")}: #{empty_fields_convert}"
      redirect_to request.referer
    end
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    @shelter.pets.each do |pet|
      if !pet.status
        flash[:shelter_delete_notice] = "This shelter cannot be deleted while pets having pending adoptions"
      end
    end
    @shelter.destroy
    redirect_to "/shelters"
  end

  private

  def empty_fields(current_params)
    @shelter_empty_fields = []
    current_params.each do |key, value|
      if value == ""
        @shelter_empty_fields << key.capitalize
      end
    end
    @shelter_empty_fields
    # This looks like a RUBY .reduce opportunity for creating that new array
  end

  def empty_fields_convert
    empty_fields_string = String.new
    if @shelter_empty_fields.count == 1
      empty_fields_string = @shelter_empty_fields.join
    else
      @shelter_empty_fields.each do |field|
        empty_fields_string += field + ", "
      end
      empty_fields_string = empty_fields_string[0..-3]
    end
    empty_fields_string
  end

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
