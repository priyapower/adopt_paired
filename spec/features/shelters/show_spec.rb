require 'rails_helper'

RSpec.describe "Shelters Show", type: :feature do
  describe "User" do
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
    end

    describe "When I visit a single shelters page" do
      it "can see a unique shelters information by id" do
        visit "/shelters/#{@shelter_1.id}"

        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_1.address)
        expect(page).to have_content(@shelter_1.city)
        expect(page).to have_content(@shelter_1.state)
        expect(page).to have_content(@shelter_1.zip)

        visit "/shelters/#{@shelter_2.id}"

        expect(page).to have_content(@shelter_2.name)
        expect(page).to have_content(@shelter_2.address)
        expect(page).to have_content(@shelter_2.city)
        expect(page).to have_content(@shelter_2.state)
        expect(page).to have_content(@shelter_2.zip)
      end

      it "can link to unique shelter page any time you see shelter name" do
        visit "/shelters/#{@shelter_2.id}"
        expect(page).to have_content(@shelter_2.name)

        expect(page).to have_link("#{@shelter_2.name}")

        click_link "#{@shelter_2.name}"
        expect(current_path).to eq("/shelters/#{@shelter_2.id}")

        expect(page).to have_content("#{@shelter_2.name}")
        expect(page).to_not have_content("#{@shelter_1.name}")
      end

      it "can see links for ALL PETS at top of every html page" do
        visit "/shelters/#{@shelter_2.id}"
        expect(page).to have_link("All Pets")
        click_link "All Pets"
        expect(current_path).to eq("/pets")
      end

      it "can see links for ALL SHELTERS at top of every html page" do
        visit "/shelters/#{@shelter_2.id}"
        expect(page).to have_link("All Shelters")
        click_link "All Shelters"
        expect(current_path).to eq("/shelters")
      end

      it "can see links to take me to that unique_shelters pets page" do
        visit "/shelters/#{@shelter_1.id}"
        expect(page).to have_link("All Pets at Shelter")
        click_link "All Pets at Shelter"
        expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
      end
    end
  end
end
