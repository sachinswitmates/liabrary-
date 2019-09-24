FactoryBot.define do
  factory :bank_account do
    bank_name {Faker::Lorem.word}
    account_number {Faker::Lorem.word}
    ifsc_code {"HDFCs23832"}
    account_holder_name{Faker::Lorem.word}
    user_id {"2"}
  end
end
