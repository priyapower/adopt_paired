require "rails_helper"

RSpec.describe "Welcome Page", type: :feature do
  describe "As a visitor" do
    it "can have a welcome page" do
      visit "/"
      expect(page).to have_content("Welcome to Adopt Don't Shop")
      expect(page).to have_content("A Denver Based Pet Adoption Website")
    end

    it "can see links for ALL PETS at top of every html page" do
      visit "/"
      expect(page).to have_link("All Pets")
      click_link "All Pets"
      expect(current_path).to eq("/pets")
    end

    it "can see links for ALL SHELTERS at top of every html page" do
      visit "/"
      expect(page).to have_link("All Shelters")
      click_link "All Shelters"
      expect(current_path).to eq("/shelters")
    end

    it "can see a nav bar on the welcome page" do
      visit "/"

      within"#nav-bar" do
        expect(page).to have_link("All Pets")
        expect(page).to have_link("All Shelters")
      end
    end
  end
end
