require 'faker'
FactoryGirl.define do
  factory :library  do
    name {Faker::Lorem.name}
    address1 {Faker::Lorem.word}
    city {Faker::Lorem.word}
    zip_code {Faker::Lorem.word}
    state {Faker::Lorem.word}
    landmark {Faker::Lorem.word}
    open {Faker::Lorem.word}
    seats {Faker::Lorem.word}
    contact_number {"9999999999"}
    monthly {100}
    quaterly {1000}
    halfyearly {3000}
    yearly {6000}
  end
end
