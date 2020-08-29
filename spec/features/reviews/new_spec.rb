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
      @review_1 = @shelter_1.reviews.create!(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')
      @review_2 = @shelter_2.reviews.create!(title: 'Sucky', rating: 0, content: 'sucks', image: 'https://www.peta.org/wp-content/uploads/2012/05/no-kill-gallery-03.jpg')

    end
    it "can see the link to add new review" do
     visit "/shelters/#{@shelter_1.id}"

     expect(page).to have_link("Add Review")

     click_link('Add Review')
     expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")
     expect(page).to have_content("#{@shelter_1.name}")
     fill_in :title, with: "Worst Shelter I've been to"
     fill_in :rating, with: 1
     fill_in :content, with: "Worst staff, poor animals they looked hungry"
     fill_in :image, with: "https://alpha.aeon.co/images/0bd4ba4f-8a60-4001-82fd-e1c47e8faf06/header_ESSAY-PA-21805359.jpg"

     click_button "Add Review"
     new_review = Review.last

     expect(current_path).to eq("/shelters/#{@shelter_1.id}")
     expect(page).to have_content(new_review.title)
     expect(page).to have_content(new_review.rating)
     expect(page).to have_content(new_review.content)
     expect(page).to have_css("img[src*='#{new_review.image}']")
     expect(page).to_not have_content(@review_2.title)
    end

    it "can not create a review without title, content and rating" do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_link("Add Review")

      click_link('Add Review')
      expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/new")
      expect(page).to have_content("#{@shelter_1.name}")

      click_button "Add Review"

      expect(page).to have_content('Review not created, required information missing')
      expect(page).to have_button('Add Review')
    end
  end
end
