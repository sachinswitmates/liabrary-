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
  describe 'scope' do
    it "library is published" do
      library = FactoryBot.create(:library,published: true)
      expect(library.published).to eq true
    end
  end
  describe 'default scope' do
    it "library is deleted_at" do
      library = FactoryBot.create(:library,deleted_at: nil)
      expect(library.deleted_at).to eq nil
    end
  end

  describe 'create_plan_on_razorpay' do
    before(:each) do
      library = FactoryBot.create(:library)
      package = 'monthly'
      @options={
          "period": (package == 'yearly') ? 'yearly' : 'monthly',
          "interval": 1,
          "item": {
            "name": "L-#{library.id}-#{library[package]}-#{package}",
            "description": "L-#{library.id}",
            "amount": library[package].to_i * 100,
            "currency": "INR"
          },
        }
    end
    it "create plan_id of packages" do
      # plan = Razorpay::Plan.create(@options)
      # expect(response).to have_http_status(400)
    end
  end

  describe 'get_interval' do
    before(:each) do
      library = FactoryBot.create(:library)
      package = 'monthly'
      @interval = library.get_interval(package)
    end
    it 'get_interval packages' do
      expect(@interval).to eq 1
    end
  end
end
