FactoryBot.define do
  factory :dog do
    sequence :name do |n|
      "My Dog #{n}"
    end
  end
end
