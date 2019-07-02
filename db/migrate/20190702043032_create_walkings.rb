class CreateWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :walkings do |t|
      t.string :status
      t.integer :lat
      t.integer :lon
      t.references :caregiver

      t.timestamps
    end
  end
end
