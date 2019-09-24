require 'rails_helper'

RSpec.describe Library, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
    it { is_expected.to validate_presence_of(:address1) }
    it { is_expected.to validate_uniqueness_of(:address1)}
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:zip_code) }
    it { is_expected.to validate_presence_of(:landmark) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:open) }
    it { is_expected.to validate_presence_of(:seats) }
    it { is_expected.to validate_presence_of(:contact_number) }
    it { is_expected.to validate_length_of(:contact_number).is_at_least(10)}
    it "should validate package" do
      library = FactoryBot.create(:library)
      expect(library[:monthly])
      expect(library[:quaterly])
      expect(library[:halfyearly])
      expect(library[:yearly]) 
    end
  end

  describe 'associations' do
    it "has a polymorphic relationship" do
      expect(subject).to have_many(:images) 
    end
    it { is_expected.to have_many(:bookings) }
    it { is_expected.to have_many(:users).through(:bookings) }
    it { is_expected.to have_many(:reviews) }
  end

  describe 'nested attributes' do
    it { is_expected.to accept_nested_attributes_for :images }
  end

  describe Library do
    it "it returns a address1,address2,landmark,city,zipcode and state in string" do
      library = FactoryBot.create(:library)
      expect(library.library_address).to eql "#{library.address1} ,#{library.address2} , #{library.landmark}, #{library.city}, #{library.zip_code}, #{library.state}"
    end
  end
end
