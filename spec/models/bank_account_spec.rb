require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:bank_name) }
    it { is_expected.to validate_presence_of(:account_number) }
    it { is_expected.to validate_presence_of(:ifsc_code) }
    it { is_expected.to validate_length_of(:ifsc_code).is_at_least(10)}
    it { is_expected.to validate_presence_of(:account_holder_name)}
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user)}
  end
end
