class ApplyController < ApplicationController
  include ActionView::Helpers::TextHelper


  def new
    # favorites
    # After MVC lesson - this should probably be something I can pass into view that removes all business&data logic from the new.html.erb
    # Probably more like @favorited_pet_ids = favorites.contents
    # Then we can call @favorited_pet_ids.each in the viewon line 4
    #Never mind - we CAN call it because we aren't doing any logic, just calling the info
    #HOWEVER, we didn't need the extra favorites
  end

  def create
    pet_ids = session[:apply_pets]
    if pet_ids.nil? # This returns true is no pets are saved
      flash[:apply_notice] = "Application not created, please select and save 1 or more pets first (see top of page)"
      render :new
    elsif
      user = Apply.new(apply_params)
      pet_ids.each do |id|
        @pet = Pet.find(id)
        if user.pet_id.nil?
          user.pet_id = @pet.id
        else
          user.pet_id << pet
        end
      end

      if user.save
        counter = pet_ids.count
        flash[:apply_complete] = "Your application has gone through for #{pluralize(counter, "pet")}"
        pet_ids.each do |pet_id|
          favorites.contents.delete(pet_id.to_i)
        end
        redirect_to "/favorites"
      else
        flash[:apply_failure] = "Your application is missing one or more elements. Pleae complete all fields before submitting your application"
        render :new
      end
      # Failures are occuring because we can't create this application BECAUSE we need to connect it to pets.... but, if we have more than one pet, we can't simply create the application... because applications can have many pets... I NEED A JOIN TABLE??

      # Following binding.pry to confirm my suspicions
      # FIRST error - some names aren't matching, this is causing an error in our session data, updated all names to match

      # SECOND error - I am not allowed to do user.save
        # This is BECAUSE - it says that I need a Pet first...
        # UHOH... our foreign keying and associations here might mess us up... we may need Apply database to live by itself for now. I really don't think it needs the database information associating it to pets
        # Yeah - looking at our model, apply currently belonga_to :pet.... this is going to mess us up..
        # On a remembering curve for how to fix our database :)

      # Went on a seperate path - updated all databases, now we have a Join Table with a primary key PetApply, and a foreign key for pet and application (supposedely)

      # Back on pry session - PetApply.new({pet_id: x[0], apply_id: user.id})

      # FROM CHECKIN
      # possble solution
      # @pet = Pet.find(??)
      # @user.pets << @pet
      # Other possible connection to PetApplication
      # params[:favorited_pets].each do |favorite_id|
      #       PetApplication.create({pet_id: favorite_id, application_id: new_application.id})
      #     end
    end
  end

  def update_chosen_pets
    session[:apply_pets] = params[:favorited_pets]
    flash[:apply_pets_notice] = "You have saved pet(s) to your application"
    redirect_to request.referer
        # research refreshing without loosing text_field user input data
  end

  private
  def apply_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
