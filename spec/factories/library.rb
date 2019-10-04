require 'faker'
FactoryBot.define do
  factory :library  do
    name {Faker::Name.unique.name}
    address1 {Faker::Address.full_address}
    city {'indore'}
    zip_code {Faker::Lorem.word}
    state {'Madhya Pradesh'}
    landmark {Faker::Lorem.word}
    open {Faker::Lorem.word}
    seats {50}
    contact_number {"9999999999"}
    monthly {500}
    user_id {2}
    booked_seats {2}
    published {'false'}
  end
end
