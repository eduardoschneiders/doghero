FactoryBot.define do
  factory :client do
    sequence :name do |n|
      "John Doe #{n}"
    end

    trait :with_dogs do
    	dogs do 2.times.map do
	    		build(:dog)
	    	end
	    end
    end
  end
end
