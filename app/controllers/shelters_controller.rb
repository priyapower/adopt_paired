class SheltersController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
    @reviews = @shelter.reviews
  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    if shelter.save
      redirect_to '/shelters'
    else
      # HOW DO I CALL THE EMPTY PARAMS???
      # When I look at params, the empty fields come through as blank strings
      # Can I create a method that would grab those empty fields? Then just add that into my flash notice?
      # Where do I create the method?
      # Following logic from other controllers, this might live as it's own method
      # Setup up a theory to follow with pry
      quantity = empty_fields.count
      flash[:shelter_fields_notice] = "Shelter Creation Warning: You are missing #{pluralize(quantity, "field")}: #{empty_fields}"
    end
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    @shelter = Shelter.find(params[:id])
    @shelter.update(shelter_params)
    redirect_to "/shelters/#{@shelter.id}"
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

  # def empty_fields
  #
  # end

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
