class CreatePetApply < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_applies do |t|
      t.references :pet, foreign_key: true
      t.references :apply, foreign_key: true
    end
  end
end
