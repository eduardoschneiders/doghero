FactoryBot.define do
  factory :walking do
    lat { 1 }
    lon { 1 }
    duration { 30 }
    dogs { create(:client, :with_dogs).dogs }
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

    trait :upcomming do
      schedule_time { 2.months.ago}  
    end 
    
    trait :outdated do
      schedule_time { 2.months.from_now}  
    end
  end
end
