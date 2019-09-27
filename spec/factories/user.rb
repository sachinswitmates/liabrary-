FactoryBot.define do
  factory :user do
    first_name {"test"}
    last_name {"test"}
    email {Faker::Internet.email}
    password {"password123"}
    role {"student"}
  end
end
