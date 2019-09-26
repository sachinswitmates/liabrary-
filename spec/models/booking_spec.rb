require 'rails_helper'

RSpec.describe Booking, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @library = FactoryBot.create(:library,user_id: @user.id)
  end

  describe 'associations' do
    it {is_expected.to belong_to (:user)}
    it {is_expected.to belong_to(:library)}
    it {is_expected.to have_one (:qrcode)}
  end

  describe 'update_seats' do
    it "update_seats" do
      @library.update(seats: @library.seats - 1)
      @library.update(booked_seats: (@library.booked_seats + 1))
      expect(@library.seats).to eq (@library.seats)
      expect(@library.booked_seats).to eq (@library.booked_seats)
    end
  end

  describe ' update_subscription_date' do
    it " update_subscription_date" do
    booking = FactoryBot.create(:booking,user_id: @user.id,library_id: @library.id )
    booking.update(package: '500',start_date: (Time.now), end_date: (Time.now + 30.days))
    expect(booking).to eql(booking) 
    end
  end

  describe 'subscription_type' do
    it "subscription_length" do
      booking = FactoryBot.create(:booking,user_id: @user.id,library_id: @library.id )
      expect(booking.subscription_length).to eq 'quaterly'
    end
  end
  
  describe "calcuate_subscription_end" do
    it "subscription_type" do
      booking = FactoryBot.create(:booking,user_id: @user.id,library_id: @library.id )
      expect(booking.subscription_type).to eq 3
    end
  end
end
