require "rails_helper"

RSpec.describe PetApply, type: :model do
  describe "relationships" do
    it { should belong_to :apply}
    it { should belong_to :pet}
  end
end
