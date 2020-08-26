class ReviewsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end
  # def new
  #   binding.pry
  #   @shelter = Shelter.find(params[:shelter_id])
  #
  #
  # end
  #
  # def create
  # end

end
