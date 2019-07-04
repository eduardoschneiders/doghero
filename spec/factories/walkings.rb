FactoryBot.define do
  factory :walking do
    lat { 1 }
    lon { 1 }
    duration { 30 }
    caregiver { create(:caregiver) }
    
    trait :with_dogs do
      dogs { create(:client, :with_dogs).dogs }
    end
  end
end
