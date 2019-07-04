FactoryBot.define do
  factory :walking do
    lat { 1 }
    lon { 1 }
    duration { 30 }
    schedule_time { Time.now }
    caregiver { create(:caregiver) }
    
    trait :with_dogs do
      dogs { create(:client, :with_dogs).dogs }
    end

    trait :with_two_dogs do
      dogs { create(:client, :with_dogs).dogs }
    end

    trait :short_time do
      duration { 30 }
    end

    trait :long_time do
      duration { 60 }
    end
  end
end
