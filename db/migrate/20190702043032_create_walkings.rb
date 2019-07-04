class CreateWalkings < ActiveRecord::Migration[5.2]
  def change
    create_table :walkings do |t|
      t.integer :status, default: 0
      t.integer :lat
      t.integer :lon
      t.references :caregiver

      t.timestamps
    end
  end
end
