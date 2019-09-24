FactoryBot.define do
  factory :image do
    Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/default_library.jpg')))
  end
end
