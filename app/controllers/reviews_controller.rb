class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:shelter_id])    
  end

end
