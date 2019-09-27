require 'faker'
FactoryBot.define do
  factory :library  do
    name {Faker::Lorem.name}
    address1 {"sdfgfdgdf"}
    city {Faker::Lorem.word}
    zip_code {Faker::Lorem.word}
    state {Faker::Lorem.word}
    landmark {Faker::Lorem.word}
    open {Faker::Lorem.word}
    seats {50}
    contact_number {"9999999999"}
    monthly {1000}
    user_id {2}
    booked_seats {2}
  end
end
