require "rails_helper"

RSpec.describe "Show reviews from shelter", type: :feature do
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
      @review_1 = @shelter_1.reviews.create!(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')

    end
    it "can see all reviews at unique shelter" do
      visit "/shelters/#{@shelter_1.id}/reviews"
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@review_1.title)
      expect(page).to have_content(@review_1.rating)
      expect(page).to have_content(@review_1.content)
      expect(page).to have_css("img[src*='#{@review_1.image}']")
    end

    it "can see a list of reviews on the shelter show page" do
      review_1 = @shelter_1.reviews.create!(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')
      visit "/shelters/#{@shelter_1.id}"
      expect(page).to have_content(review_1.title)
      expect(page).to have_content(review_1.rating)
      expect(page).to have_content(review_1.content)
      expect(page).to have_css("img[src*='#{review_1.image}']")
    end
  end
end
