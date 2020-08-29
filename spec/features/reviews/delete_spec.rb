require "rails_helper"

RSpec.describe "Review delete page", type: :feature do
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
      @review_1 = @shelter_2.reviews.create!(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')
      @review_2 = @shelter_2.reviews.create!(title: 'Sucky', rating: 0, content: 'sucks', image: 'https://www.peta.org/wp-content/uploads/2012/05/no-kill-gallery-03.jpg')
    end
    it "can delete a review" do
      visit "/shelters/#{@shelter_2.id}"
      expect(page).to have_content(@review_2.title)

      within "#review-#{@review_2.id}" do
        expect(page).to have_link("Delete Review")
        click_link "Delete Review"
      end
      expect(current_path).to eq("/shelters/#{@shelter_2.id}")

      expect(page).to_not have_content(@review_2.title)
      expect(page).to have_content(@review_1.title)
    end

  end
end
# When I delete a shelter review I am returned to the shelter's show page
# And I should no longer see that shelter review
