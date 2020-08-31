require "rails_helper"

RSpec.describe "Apply new page", type: :feature do
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
    end
    it "make a new application form from a favorited pet" do
      visit "/pets/#{@pet_4.id}"
      click_button("Favorite This Pet!")
      expect(current_path).to eq("/pets/#{@pet_4.id}")

      visit "/pets/#{@pet_3.id}"

      click_button("Favorite This Pet!")

      expect(current_path).to eq("/pets/#{@pet_3.id}")

      click_link "My Favorites"

      expect(current_path).to eq("/favorites")

      expect(page).to have_link("Adopt from Favorited Pets!")

      click_link "Adopt from Favorited Pets!"

      expect(current_path).to eq("/apply/new")

      expect(page).to have_content(@pet_3.name)

      expect(page).to have_content(@pet_4.name)

      within "#apply-pet-#{@pet_4.id}" do
        check("Adopt Me!")
        click_button("Save changes")
      end

      expect(page).to have_content("You have saved pet(s) to your application")
      # save_and_open_page
      fill_in :name, with: "UserPErson"
      fill_in :address, with: "123 Main Street"
      fill_in :city, with: "Denver"
      fill_in :state, with: "NY"
      fill_in :zip, with: 99999
      fill_in :phone_number, with: "(555)555-5555"
      fill_in :description, with: "I am a User"

      click_button "Submit My Application"
      # THIS IS WHERE WE AT
      # OUR CREATE NEVER SAVED OUR USER
      # CURRENT ERROR MESSAGE;
      # Failure/Error: expect(page).to have_content("Your application has gone through for the pet: #{@pet_4.name}")  Capybara::ElementNotFound: Unable to find xpath "/html"

      expect(page).to have_content("Your application has gone through for the pet: #{@pet_4.name}")

      expect(current_path).to eq("/favorites")

      expect(page).to have_content(@pet_3.name)
      expect(page).to_not have_content(@pet_4.name)
    end
  end
end
