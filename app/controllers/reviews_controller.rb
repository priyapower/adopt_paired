class ReviewsController < ApplicationController

  def index
    @shelter = Shelter.find(params[:shelter_id])
  end
  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    # review = shelter.reviews.create!(review_params)
    # redirect_to "/shelters/#{review.shelter_id}"
    # review = Review.new(review_params)
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{review.shelter_id}"
    else
      flash[:notice] = "Review not created, required information missing"
      render :new
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end

end
