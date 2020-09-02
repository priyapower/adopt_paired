require "rails_helper"

RSpec.describe "Shelters Update/New Warnings", type: :feature do
  describe "As a visitor" do
    before :each do
      @shelter_1 = Shelter.create!(name: "The Humane Society - Denver",
        address: "1 Place St",
        city: "Denver",
        state: "CO",
        zip: "11111")
      @shelter_2 = Shelter.create!(name: "Denver Animal Shelter",
        address: "7 There Blvd",
        city: "Denver",
        state: "CO",
        zip: "22222")

      image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2019/01/Chihuahua-Mixes.jpg"
      image_2 = "https://www.loveyourdog.com/wp-content/uploads/2019/12/Catahoula-Pitbull-Mix-900x500.jpg"
      image_3 = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47475338/2/?bust=1586831049&width=720"
      image_4 = "https://www.iamcasper.com/wp-content/uploads/2018/03/Torbie-Ragdoll-1030x790.png"

      @pet_1 = Pet.create!(image: image_1,
        name: "Tinkerbell",
        approximate_age: 3,
        sex: "Female",
        shelter_id: "#{@shelter_1.id}",
        description: "Adorable chihuahua mix with lots of love to give",
        status: true)
      @pet_2 = Pet.create!(image: image_2,
        name: "George",
        approximate_age: 5,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}",
        description: "This pitty mix will melt your heart with his sweet temperament",
        status: true)
      @pet_3 = Pet.create!(image: image_3,
        name: "Ruby",
        approximate_age: 0,
        sex: "Female",
        shelter_id: "#{@shelter_2.id}",
        description: "This flat-coated retriever mix is your best friend on walks and is perfect for families with kids",
        status: true)
      @pet_4 = Pet.create!(image: image_4,
        name: "Pierce Brosnan",
        approximate_age: 7,
        sex: "Male",
        shelter_id: "#{@shelter_2.id}",
        description: "This ragdoll mix is a fluffy and friendly addition to your household",
        status: true)

      @application_1 = Apply.create!(name: "Third Person",
        address: "96 There St",
        city: "CityPlace",
        state: "StateLocation",
        zip: 88888,
        phone_number: "(555)555-5555",
        description: "1.Person from Apply Index Test")
      @application_2 = Apply.create!(name: "Fourth Person",
        address: "96 There St",
        city: "CityPlace",
        state: "StateLocation",
        zip: 88888,
        phone_number: "(555)555-5555",
        description: "2.Person from Apply Index Test")

      PetApply.create!({pet: @pet_1, apply: @application_1})
      PetApply.create!({pet: @pet_2, apply: @application_1})
      PetApply.create!({pet: @pet_2, apply: @application_2})
      PetApply.create!({pet: @pet_3, apply: @application_2})

      @review_1 = @shelter_2.reviews.create!(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')
      @review_2 = @shelter_2.reviews.create!(title: 'Sucky', rating: 0, content: 'sucks', image: 'https://www.peta.org/wp-content/uploads/2012/05/no-kill-gallery-03.jpg')
    end

    it "can warn a user when new shelter fields are incomplete and specify the field" do
      visit '/shelters'

      click_link 'New Shelter'

      expect(current_path).to eq('/shelters/new')

      fill_in :name, with: "Priya's Shelter O' Love"
      fill_in :address, with: "17 Here Ave"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      click_on 'Create Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("Shelter Creation Warning: You are missing the required field: Zip")

      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: 99999
      click_on 'Create Shelter'

      expect(current_path).to eq('/shelters')
      expect(page).to have_content("Shelter Creation Warning: You are missing the required fields: Name, Address")
    end

    it "can warn a user when edit shelter fields are incomplete and specify the field" do

      # When I am updating or creating a new shelter
      # If I try to submit the form with incomplete information
      # I see a flash message indicating which field(s) I am missing
    end

  end
end
