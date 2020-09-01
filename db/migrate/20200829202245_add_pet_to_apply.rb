class AddPetToApply < ActiveRecord::Migration[5.2]
  def change
    add_reference :applies, :pet, foreign_key: true
  end
end
