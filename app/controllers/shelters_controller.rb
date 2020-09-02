class SheltersController < ApplicationController
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
      binding.pry
      flash[:shelter_fields_notice] = "Shelter Creation Warning: You are missing the required #{pluralize("field")}: HOW DO I CALL THE EMPTY PARAMS???"
    end
    # Shelter.create(shelter_params)
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
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

end
