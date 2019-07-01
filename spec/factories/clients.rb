FactoryBot.define do
  factory :client do
    sequence :name do |n|
      "John Doe #{n}"
    end
  end
end
