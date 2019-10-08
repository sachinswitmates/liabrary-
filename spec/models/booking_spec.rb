require 'rails_helper'

RSpec.describe Booking, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user)
    @library = FactoryBot.create(:library,user_id: @user.id)
    @booking = FactoryBot.create(:booking,user_id: @user.id,library_id: @library.id )
  end
  
  describe 'enum payment status' do
    it { should define_enum_for(:payment_status).with(paid: 0, unpaid: 1) } 
  end

  describe 'associations' do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to belong_to(:library)}
    it {is_expected.to have_one (:qrcode)}
  end

  describe 'update_seats' do
    it "update_seats" do
      expect(@booking.update_seats).to eql(@booking.update_seats)
    end
  end

  describe 'update subscription date' do
    it " update start and end date" do
    expect(@booking.update_subscription_date).not_to be_nil
    end
  end

  describe 'subscription_type' do
    it "subscription_length" do
      expect(@booking.subscription_length).to eq 'quaterly'
    end
  end
  
  describe "calcuate_subscription_end" do
    it "subscription_type" do
      expect(@booking.subscription_type).to eq 3
    end
  end

  describe 'user mailer' do
    it "sends an email after booking a library to student and library owner" do
      expect { @booking.send_booking_notification_email }.to change { ApplicationMailer.deliveries.count }.by(2)
    end
  end

  describe 'notify student' do
    let(:mail) { UserMailer.notify_student(@user) } 

     it 'renders the subject' do
      expect(mail.subject).to eql("Your Booking Has Done")
    end
    it 'renders the receiver email' do
      expect(mail.to).to eql([@user.email])
    end
  end

  describe 'notify library owner' do
    user = FactoryBot.build(:user, email: 'libraryowner@gmail.com',role: 'library_owner')
    let(:mail) { UserMailer.notify_booking_library_owner(user) } 

     it 'renders the subject' do
      expect(mail.subject).to eql("Library has booked")
    end
    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end
  end

  describe "generate_qrcode" do
    it 'get qrcode' do
      expect(@booking.qrcode).not_to be_nil
    end
  end
  
  describe 'generate_token' do
    it 'generate token' do
      expect(@booking.generate_token).not_to be_nil
    end
  end
end
