require 'rails_helper'

RSpec.describe Review, type: :model do
  before :each do
    @review = FactoryBot.build(:review)
  end

  it "should not be valid without a rating" do
    @review.rating = nil
    expect(@review).not_to be_valid
  end
  it "should not be valid without a comment" do
    @review.comment = nil
    expect(@review).not_to be_valid
  end 
end
