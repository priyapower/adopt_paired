require "rails_helper"

RSpec.describe "Review new page", type: :feature do
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
    end
    # it "can see the link to add new review" do
    #  visit "/shelters/#{@shelter_1.id}"
    #
    #  expect(page).to have_link("Add Review")
    #
    #  click_link('Add Review')
    #
    #  expect(current_path).to eq("/reviews/new")
    #
    #
    # end
  end
end

# On this new page, I see a form where I must enter:
# - title
# - rating
# - content
# I also see a field where I can enter an optional image (web address)
# When the form is submitted, I should return to that shelter's show page
# and I can see my new review
