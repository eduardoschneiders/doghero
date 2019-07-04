require 'rails_helper'

RSpec.describe Walking, type: :model do
  describe :duration do
    let(:walking) { build(:walking, :with_dogs, duration: nil) }

    it 'should allow walking to set a a short duration' do
      expect { walking.short_time! }.to change { walking.duration }.from(nil).to(30)
    end

    it 'should allow walking to set a a long duration' do
      expect { walking.long_time! }.to change { walking.duration }.from(nil).to(60)
    end
  end
end
