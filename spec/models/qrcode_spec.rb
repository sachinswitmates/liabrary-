require 'rails_helper'

RSpec.describe Qrcode, type: :model do
  describe 'associations' do
    it {is_expected.to belong_to(:booking)}
  end
end
