require 'rails_helper'

RSpec.describe Walking, type: :model do
  let(:walking) { build(:walking, :with_dogs, duration: nil) }
  
  describe :duration do
    it 'should allow walking to set a a short duration' do
      expect { walking.short_time! }.to change { walking.duration }.from(nil).to(30)
    end

    it 'should allow walking to set a a long duration' do
      expect { walking.long_time! }.to change { walking.duration }.from(nil).to(60)
    end
  end

  describe :end_time do
    it 'should calculate end time based on duration' do
      time = Time.zone.now
      walking.schedule_time = time
      walking.short_time!

      end_time = (time + 30.minutes).change(sec: 0)

      expect(walking.end_time).to eql(end_time)
    end
  end
end
