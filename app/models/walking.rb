class Walking < ApplicationRecord
	belongs_to :caregiver
	has_and_belongs_to_many :dogs

	validates :lat, :lon, presence: true
end
