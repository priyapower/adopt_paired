require 'rails_helper'

RSpec.describe "Pets Show page", type: :feature do
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
    end

    it "can see a unique pet with two new attributes: description and status" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_css("img[src*='#{@pet_1.image}']")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.approximate_age)
      expect(page).to have_content(@pet_1.sex)
      expect(page).to have_content(@pet_1.description)
      expect(@pet_1.status).to eq(true)
      expect(page).to have_content(@shelter_1.name)
    end

    it "can link to unique shelter page any time you see shelter name" do
      visit "/pets/#{@pet_2.id}"

      expect(page).to have_content(@shelter_1.name)

      expect(page).to have_link("#{@shelter_1.name}")

      click_link "#{@shelter_1.name}"
      expect(current_path).to eq("/shelters/#{@shelter_1.id}")

      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to_not have_content("#{@shelter_2.name}")
    end

    it "can link to unique pet page any time you see pet name" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_content(@pet_1.name)

      expect(page).to have_link("#{@pet_1.name}")

      click_link "#{@pet_1.name}"
      expect(current_path).to eq("/pets/#{@pet_1.id}")

      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to_not have_content("#{@pet_2.name}")
    end

    it "can see links for ALL PETS at top of every html page" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_link("All Pets")
      click_link "All Pets"
      expect(current_path).to eq("/pets")
    end

    it "can see links for ALL SHELTERS at top of every html page" do
      visit "/pets/#{@pet_1.id}"
      expect(page).to have_link("All Shelters")
      click_link "All Shelters"
      expect(current_path).to eq("/shelters")
    end
  end
end
