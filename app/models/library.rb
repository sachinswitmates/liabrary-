class Library < ApplicationRecord
  
  #validations
  # validates :name, presence: true, uniqueness: true
  # validates :address, presence: true, uniqueness: true
  validates :open, presence: true
  validates :seats, presence: true
  validates :availability, presence: true
  validates :contact_number,presence: true,uniqueness:true

  #associations
  belongs_to :user, optional: true
  has_many :images, :as => :imageable
  

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

end
