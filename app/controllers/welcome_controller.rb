class WelcomeController < ApplicationController
  def index
    @pets = Pet.all
    @favorites = Favorite.new(session[:favorite])
  end
end
