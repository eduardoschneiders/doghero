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

  describe :price do
    let(:walking) { walking = build(:walking, duration: duration, dogs: dogs) }

    context :short_time do
      let(:duration) { 30 }

      context :one_dog do
        let(:dogs) { 1.times.map { create(:dog, client: create(:client)) } }

        it 'shold calculate a price for one dog' do
          expect { walking.save }.to change { walking.price }.from(nil).to(25)
        end
      end

      context :three_dogs do
        let(:dogs) { 3.times.map { create(:dog, client: create(:client)) } }

        it 'shold calculate a price for one dog end two additionals' do
          expect { walking.save }.to change { walking.price }.from(nil).to(55)
        end
      end

      context :four_dogs do
        let(:dogs) { 4.times.map { create(:dog, client: create(:client)) } }

        it 'shold calculate a price for one dog end three additionals' do
          expect { walking.save }.to change { walking.price }.from(nil).to(70)
        end
      end
    end

    context :long_time do
      let(:duration) { 60 }

      context :one_dog do
        let(:dogs) { 1.times.map { create(:dog, client: create(:client)) } }

        it 'shold calculate a price for one dog' do
          expect { walking.save }.to change { walking.price }.from(nil).to(35)
        end
      end

      context :three_dogs do
        let(:dogs) { 3.times.map { create(:dog, client: create(:client)) } }

        it 'shold calculate a price for one dog end two additionals' do
          expect { walking.save }.to change { walking.price }.from(nil).to(75)
        end
      end

      context :four_dogs do
        let(:dogs) { 4.times.map { create(:dog, client: create(:client)) } }

        it 'shold calculate a price for one dog end three additionals' do
          expect { walking.save }.to change { walking.price }.from(nil).to(95)
        end
      end
    end
  end
end
