require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = FactoryBot.build(:user,role: 'library_owner')
  end

  it "should not be valid without a first_name" do
    @user.first_name = nil
    expect(@user).not_to be_valid
  end
  it "should not be valid without a last_name" do
    @user.last_name = nil
    expect(@user).not_to be_valid
  end
  it "should not be valid without a email" do
    @user.email = nil
    expect(@user).not_to be_valid
  end
  it "should not be valid without a encrypted_password" do
    @user.password = nil
    expect(@user).not_to be_valid
  end

  describe 'associations' do
    it "has a polymorphic relationship" do
      expect(subject).to have_one(:image) 
    end
    it { is_expected.to have_one(:bank_account) }
    it { is_expected.to have_many(:bookings) }
    it { is_expected.to have_many(:libraries).through(:bookings) }
    it { is_expected.to have_many(:reviews)}
  end

  describe 'user name method' do
    it "returns a first_name and last_name in a string " do
      expect(@user.user_name).to eql "#{@user.first_name} #{@user.last_name}"
    end

  describe 'enum role' do
    it { is_expected.to define_enum_for(:role).with([:admin, :library_owner, :student]) }
  end

  end
  describe 'user mailer' do
    it "sends an email after creating library to library_owner and admin" do
      @user = FactoryBot.create(:user, email: 'admin@gmail.com', role: 'admin')
      expect { @user.send_notification_email }.to change { ApplicationMailer.deliveries.count }.by(2)
    end
  end

  describe 'notify library owner' do
    let(:mail) { UserMailer.notify_library_owner(@user) }
    it 'renders the subject' do
      expect(mail.subject).to eql('Your library has created')
    end
    it 'renders the receiver email' do
      expect(mail.to).to eql([@user.email])
    end
  end

  describe 'notify admin' do
    # @user = FactoryBot.create(:user, email: 'admin@gmail.com', role: 'admin')
    let(:mail) { UserMailer.notify_admin(@user) } 
     it 'renders the subject' do
      expect(mail.subject).to eql("Notification")
    end
    it 'renders the receiver email' do
      expect(mail.to).to eql([@user.email])
    end
  end
end
