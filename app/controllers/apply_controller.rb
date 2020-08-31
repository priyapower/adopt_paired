class ApplyController < ApplicationController

  def new
    favorites
    # After MVC lesson - this should probably be something I can pass into view that removes all business&data logic from the new.html.erb
    # Probably more like @favorited_pet_ids = favorites.contents
    # Then we can call @favorited_pet_ids.each in the viewon line 4
  end

  def create
    pet_ids = session[:apply_pets]
    if pet_ids.nil? # This returns true is no pets are saved
      flash[:apply_notice] = "Application not created, please select and save 1 or more pets first (see top of page)"
      render :new
    else
      user = Apply.new(apply_params)
      # Failures are occuring because we can't create this application BECAUSE we need to connect it to pets.... but, if we have more than one pet, we can't simply create the application... because applications can have many pets... I NEED A JOIN TABLE??

      # Following binding.pry to confirm my suspicions
      # FIRST error - some names aren't matching, this is causing an error in our session data, updated all names to match

      # SECOND error - I am not allowed to do user.save
        # This is BECAUSE - it says that I need a Pet first...
        # UHOH... our foreign keying and associations here might mess us up... we may need Apply database to live by itself for now. I really don't think it needs the database information associating it to pets
        # Yeah - looking at our model, apply currently belonga_to :pet.... this is going to mess us up..
        # On a remembering curve for how to fix our database :)
    end
  end

  # params[:favorited_pets].each do |favorite_id|
  #       PetApplication.create({pet_id: favorite_id, application_id: new_application.id})
  #     end

  def update_chosen_pets
    session[:apply_pets] = params[:favorited_pets]
    flash[:apply_pets_notice] = "You have saved pet(s) to your application"
    redirect_to request.referer
        # research refreshing without loosing text_field user input data
  end

  private
  def apply_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description, :pet_id)
  end
end
