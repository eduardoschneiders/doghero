class Walking < ApplicationRecord
  belongs_to :caregiver
  has_and_belongs_to_many :dogs

  enum status: { scheduled: 0, started: 1, finished: 2 }
  enum duration: { short_time: 30, long_time: 60 }

  validates :lat, :lon, :duration, presence: true

  def duration
    self.duration_before_type_cast
  end
end
