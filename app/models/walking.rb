class Walking < ApplicationRecord
  belongs_to :caregiver
  has_and_belongs_to_many :dogs
  before_save :remove_sec_from_schedule_time, :calculate_price

  enum status: { scheduled: 0, started: 1, finished: 2 }
  enum duration: { short_time: 30, long_time: 60 }

  validates :lat, :lon, :duration, :schedule_time, :dogs, presence: true

  def duration
    self.duration_before_type_cast
  end

  def end_time
    schedule_time + duration.minutes
  end

  private

  def remove_sec_from_schedule_time
    self.schedule_time = schedule_time.change(sec: 0)
  end

  def calculate_price
    self.price = short_time? ? price_for_short_time : price_for_long_time
  end

  def price_for_short_time
    (dogs.size - 1).times.inject(25) { |total, dog| total += 15 }
  end

  def price_for_long_time
    (dogs.size - 1).times.inject(35) { |total, dog| total += 20 }
  end
end
