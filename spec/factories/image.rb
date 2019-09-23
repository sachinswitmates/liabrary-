require 'spec_helper'
FactoryGirl.define do
  factory :image do
    avatar Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/support/default_library.jpg')))
  end
end
