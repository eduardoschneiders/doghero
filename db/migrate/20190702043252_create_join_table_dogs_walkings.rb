class CreateJoinTableDogsWalkings < ActiveRecord::Migration[5.2]
  def change
  	create_join_table :dogs, :walkings do |t|
	    t.index [:dog_id, :walking_id]
	    t.index [:walking_id, :dog_id]
    end
  end
end
