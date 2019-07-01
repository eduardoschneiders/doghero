FactoryBot.define do
  factory :dog do
    sequence :name do |n|
      "My Dog #{n}"
    end

    client { create(:client) }
  end
end
