class Library < ApplicationRecord
  default_scope -> { where(deleted_at: nil) } 

  #validations
  # validates :name, presence: true, uniqueness: true
  validates :address1, presence: true, uniqueness: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :landmark, presence: true
  validates :state, presence: true
  validates :open, presence: true
  validates :seats, presence: true
  validates :availability, presence: true
  validates :contact_number,presence: true #uniqueness:true
  
  
  #associations
  belongs_to :user, optional: true
  has_many :images, :as => :imageable
  has_many :bookings

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  
  scope :published, -> { where(:published => true) }

  def library_address
    "#{self.address1} ,#{self.address2} , #{self.landmark}, #{self.city}, #{self.zip_code}, #{self.state}"
  end



end