require 'rails_helper'

RSpec.describe Image, type: :model do
  it { is_expected.to have_db_column(:imageable_id).of_type(:integer) }
  it { is_expected.to have_db_column(:imageable_type).of_type(:string) }

  it { is_expected.to belong_to(:imageable) }
end
