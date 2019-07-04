class AddPropertiesToWalking < ActiveRecord::Migration[5.2]
  def change
  	add_column :walkings, :schedule_time, :datetime
  	add_column :walkings, :price, :integer
  	add_column :walkings, :duration, :integer
  end
end
