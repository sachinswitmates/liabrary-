class Library < ApplicationRecord
  default_scope -> { where(deleted_at: nil) } 

  #validations
  validates :name, presence: true, uniqueness: true
  validates :address1, presence: true, uniqueness: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :landmark, presence: true
  validates :state, presence: true
  validates :open, presence: true
  validates :seats, presence: true
  validates :contact_number,presence: true ,length: {minimum: 10, maximum: 10}
  validate :validate_package
  
  #associations
  #belongs_to :user, optional: true
  has_many :images, :as => :imageable
  has_many :bookings
  has_many :users, :through => :bookings
  has_many :reviews

  #callbacks
  after_create :create_plan_on_razorpay

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  
  scope :published, -> { where(:published => true) }
  PACKAGES = ['monthly', 'quaterly', 'halfyearly', 'yearly']

  def library_address
    "#{self.address1} ,#{self.address2} , #{self.landmark}, #{self.city}, #{self.zip_code}, #{self.state}"
  end

  def validate_package
    unless monthly.present? || quaterly.present? || halfyearly.present? || yearly.present?
      errors.add(:monthly, "You have to fill atleast one package ")
      errors.add(:quaterly, "You have to fill atleast one package")
      errors.add(:halfyearly, "You have to fill atleast one package")
      errors.add(:yearly, "You have to fill atleast one package ")
    end
  end

  def send_published_notification_email
    library_owner = User.find_by(id: self&.user_id)
    UserMailer.notify_library_owner_published_library(library_owner).deliver_now if library_owner
  end

  def create_plan_on_razorpay
    PACKAGES.each do |package|
      if self[package].present?
        options={
          "period": (package == 'yearly') ? 'yearly' : 'monthly',
          "interval": get_interval(package),
          "item": {
            "name": "L-#{self.id}-#{self[package]}-#{package}",
            "description": "L-#{self.id}-#{self[package]}-#{package}",
            "amount": self[package].to_i * 100,
            "currency": "INR"
          },
        }
        begin
          plan = Razorpay::Plan.create(options)
          if plan.id.present?
            self.update_attribute("#{package}_plan_id", plan.id)
          end
        rescue => e
          puts e.message
        end
      end
    end
  end

  def get_interval(package)
    if package == 'monthly'
      1
    elsif package == 'quaterly'
      3
    elsif package == 'halfyearly'
      6
    elsif package == 'yearly'
      1
    end
  end
end


