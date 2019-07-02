FactoryBot.define do
  factory :caregiver do
	sequence :name do |n|
      "Caregiver name #{n}"
    end
  end
end
