class CreateFacilities < ActiveRecord::Migration[5.0]
  def change
    create_table :facilities do |t|
      t.string :name
      t.string :number
      t.string :admin_name
      t.integer :capacity
      t.datetime :approval_date

      t.timestamps
    end
  end
end
