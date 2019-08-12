class Library < ApplicationRecord
  default_scope -> { where(deleted_at: nil) } 

  #validations
  # validates :name, presence: true, uniqueness: true
  # validates :address, presence: true, uniqueness: true
  validates :open, presence: true
  validates :seats, presence: true
  validates :availability, presence: true
  validates :contact_number,presence: true #uniqueness:true
  
  
  #associations
  belongs_to :user, optional: true
  has_many :images, :as => :imageable

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  
  scope :published, -> { where(:published => true) }

  def library_address
    "#{self.address1} ,#{self.address2} , #{self.city}, #{self.landmark},#{self.zip_code}, #{self.state}"
  end



end