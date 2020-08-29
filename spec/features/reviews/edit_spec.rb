require "rails_helper"

RSpec.describe "Edit a review", type: :feature do
  describe "As a visitor I edit a review" do
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
      @review_1 = @shelter_1.reviews.create!(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')
      @review_2 = @shelter_2.reviews.create!(title: 'Sucky', rating: 0, content: 'sucks', image: 'https://www.peta.org/wp-content/uploads/2012/05/no-kill-gallery-03.jpg')
    end
    it "I can see a link to edit a shelter review" do
     visit "/shelters/#{@shelter_1.id}"

     expect(page).to have_button("Edit Review")
    end
    it "can edit a review" do
      visit "/shelters/#{@shelter_1.id}"

      click_on "Edit Review"

      expect(current_path).to eq("/reviews/#{@review_1.id}/edit")

      fill_in :title, with: "Terrible"
      fill_in :rating, with: 1
      fill_in :content, with: "They let me adopt a sick dog"

      click_on "Submit your Edits"

      expect(page).to have_content("Terrible")
      expect(page).to have_content(1)
      expect(page).to have_content("They let me adopt a sick dog")
    end
  end
end
