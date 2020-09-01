require "rails_helper"

RSpec.describe "Apply Show Page", type: :feature do
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
        status: false)
      @pet_2 = Pet.create!(image: image_2,
        name: "George",
        approximate_age: 5,
        sex: "Male",
        shelter_id: "#{@shelter_1.id}",
        description: "This pitty mix will melt your heart with his sweet temperament",
        status: false)
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
    end
    it "can have an apply index page" do
      visit "/pets/#{@pet_2.id}"
      expect(page).to have_link("View All Applications for This Pet")
      click_link "View All Applications for This Pet"
      expect(current_path).to eq("/pets/#{@pet_2.id}/apply")
      expect(page).to have_content(@application_1.name)
      expect(page).to have_link(@application_1.name)
      expect(page).to have_content(@application_2.name)
      expect(page).to have_link(@application_2.name)
      # Link goes to "/apply/#{@application.id}" or '/apply/:id'
    end
  end
end
