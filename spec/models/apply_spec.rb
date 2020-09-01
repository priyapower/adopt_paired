require "rails_helper"

RSpec.describe Apply, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :phone_number}
    it { should validate_presence_of :description}
  end

  describe "relationships" do
    # it { should belong_to :pet}
    # This currently seems wrong... I think what is more correct I have below as a comment
        # it { should have_many :pet_apply} # maybe :pet_applies???
        # it { should have_many(:pets).through(:pet_apply)} # is this :pet or :pets??

    it { should have_many :pet_apply}
    it { should have_many(:pets).through(:pet_apply)}
  end

end
