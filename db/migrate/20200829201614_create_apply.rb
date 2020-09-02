class CreateApply < ActiveRecord::Migration[5.2]
  def change
    create_table :applies do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone_number
      t.string :description

      t.timestamps
    end
  end
end
