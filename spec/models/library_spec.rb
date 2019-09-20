require 'rails_helper'

RSpec.describe Library, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name)}
    it { should validate_presence_of(:address1) }
    it { should validate_uniqueness_of(:address1)}
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:landmark) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:open) }
    it { should validate_presence_of(:seats) }
    it { should validate_presence_of(:contact_number) }
    it { should validate_length_of(:contact_number).is_at_least(10)}
   #it { is_expected.to validate_presence_of(:name) }
  end

  context 'associations' do
    it { should have_many(:bookings) }
    it { should have_many(:users).through(:bookings) }
    it "has a polymorphic relationship" do
      expect(subject).to have_many(:images) 
    end
    it { should have_many(:reviews) }
  end

  context 'nested attributes' do
    it { should accept_nested_attributes_for :images }
  end

  describe Library do
    it "it returns a address1,address2,landmark,city,zipcode and state in string" do
      library = FactoryGirl.create(:library)
      expect(library.library_address).to eql "#{library.address1} ,#{library.address2} , #{library.landmark}, #{library.city}, #{library.zip_code}, #{library.state}"
    end
  end
end
