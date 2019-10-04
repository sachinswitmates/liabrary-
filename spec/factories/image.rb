FactoryBot.define do
  factory :image do
  avatar {File.open(File.join(Rails.root, '/spec/support/default_library.jpg'))}
  end
end
