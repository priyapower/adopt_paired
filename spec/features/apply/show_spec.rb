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
    end

    it "can have a show page for each unique application" do
      visit "/apply/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.phone_number)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_link(@pet_2.name)

      expect(page).to_not have_content(@pet_3.name)
    end

    it "can approve an application for each pet and change status and confirm who it is on hold for" do
      visit "/apply/#{@application_2.id}"

      within "#application-pet-#{@pet_2.id}" do
        check("Approve Application for this Pet")
      end

      within "#application-pet-#{@pet_3.id}" do
        check("Approve Application for this Pet")
        click_button("Save changes")
      end
      expect(current_path).to eq("/pets/#{@pet_3.id}")
      expect(page).to have_content("Status: Pending Adoption")
      expect(page).to have_content("Pet on Hold: for #{@application_2.name}")
    end

    it "can approve more than one pet" do
      visit "/apply/#{@application_1.id}"
      within "#application-pet-#{@pet_1.id}" do
        check("Approve Application for this Pet")
        click_button("Save changes")
      end
      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(page).to have_content("Status: Pending Adoption")
      expect(page).to have_content("Pet on Hold: for #{@application_1.name}")

      visit "/apply/#{@application_1.id}"
      within "#application-pet-#{@pet_2.id}" do
        check("Approve Application for this Pet")
        click_button("Save changes")
      end
      expect(current_path).to eq("/pets/#{@pet_2.id}")
      expect(page).to have_content("Status: Pending Adoption")
      expect(page).to have_content("Pet on Hold: for #{@application_1.name}")

      visit "/apply/#{@application_1.id}"
    end

    it "can prevent more than one application for a pet" do
      visit "/pets/#{@pet_2.id}/apply"
      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_2.name)

      visit "/apply/#{@application_1.id}"
      within "#application-pet-#{@pet_2.id}" do
        check("Approve Application for this Pet")
        click_button("Save changes")
      end

      visit "/apply/#{@application_2.id}"
      expect(page).to_not have_content(@pet_2.name)

      visit "/pets/#{@pet_2.id}/apply"
      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_2.name)
    end

  end
end
