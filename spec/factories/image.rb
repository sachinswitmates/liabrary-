FactoryBot.define do
  factory :image do
  avatar {File.open(File.join(Rails.root, '/spec/support/image/avatar/default_library.jpg'))}
  end
end
