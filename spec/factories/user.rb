FactoryGirl.define do
  factory :user do
    first_name {"test"}
    last_name {"test"}
    email {"test@example.com"}
    password {"password123"}
    role {"library_owner"}
  end
end
