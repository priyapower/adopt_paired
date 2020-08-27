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

  def edit
    @shelter = Shelter.find(params[:shelter_id])
    @review = @shelter.reviews.find(params[:review_id])
  end

  def update
    @shelter = Shelter.find(params[:shelter_id])
    @review = @shelter.reviews.find(params[:review_id])
    if @review.update(review_params)
      redirect_to "/shelters/#{@review.shelter_id}"
    else
      flash[:notice] = "One or more fields missing content."
      redirect_to "/reviews/#{@review.id}/edit"
    end
  end
  private

  def review_params
    params.permit(:title, :rating, :content, :image)
  end

end
