require "rails_helper"

RSpec.describe Review, type: :model do
  describe "validations" do
    it { should validate_presence_of :title}
    it { should validate_presence_of :rating}
    it { should validate_presence_of :content}
    it { should allow_value("", nil).for(:image) }
  end

  describe "relationships" do
    it { should belong_to :shelter}
  end

  describe "instance methods" do
    it '.title' do
      shelter_1 = Shelter.create!(name: "The Humane Society - Denver",
        address: "1 Place St",
        city: "Denver",
        state: "CO",
        zip: "11111")

      review_1 = shelter_1.reviews.create!(title: 'Best Shelter EVA', rating: 5, content: "Found my forever friend!", image: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Dog_in_animal_shelter_in_Washington%2C_Iowa.jpg/738px-Dog_in_animal_shelter_in_Washington%2C_Iowa.jpg")

      expect(review_1.title).to eq('Best Shelter EVA')
    end
  end
end
