class Walking < ApplicationRecord
	belongs_to :caregiver
	has_and_belongs_to_many :dogs

	enum status: { scheduled: 0, started: 1, finished: 2 }
	validates :lat, :lon, presence: true
end
