class Booking < ApplicationRecord 
  enum payment_status: [:paid, :unpaid]

  #associations
  belongs_to :user, optional:true
  belongs_to :library, optional:true
  has_one :qrcode

  # Callbacks
  after_create :update_seats
  after_create :update_subscription_date
  after_create :generate_qrcode
  #after_create :create_subscription_on_razorpay

  def update_seats
    if library.seats > 0
      library.decrement!(:seats)
      library.increment!(:booked_seats)
    end
  end 

  def update_subscription_date
    self.start_date = Time.now
    self.end_date = calcuate_subscription_end
    self.save
  end 

  def subscription_type
    if self.subscription_length == 'monthly'
      1
    elsif self.subscription_length == 'quaterly'
      3
    elsif self.subscription_length == 'halfyearly'
      6
    elsif self.subscription_length == 'yearly'
      12
    end
  end

  def calcuate_subscription_end
    if subscription_type == 1
      Time.now + 30.days
    elsif subscription_type == 3
      Time.now + 90.days
    elsif subscription_type == 6
      Time.now + 180.days
    elsif subscription_type == 12
      Time.now + 364.days
    end
  end

  def send_booking_notification_email
    UserMailer.notify_student(self.user).deliver_now
    library_owner = User.find_by(id: self.library&.user_id)
    UserMailer.notify_booking_library_owner(library_owner).deliver_now if library_owner
  end

  def generate_qrcode
    self.token = generate_token
    self.save
    @qr = RQRCode::QRCode.new(self.token, :size => 4, :level => :h)
    png = @qr.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 120,
          border_modules: 4,
          module_px_size: 6,
          file: nil 
        )
    filename = "#{Rails.root}/public/code_#{self.id}.png"
    file = File.new(filename, "w")
    File.write(filename, png.to_s.force_encoding('UTF-8'))
    file = File.open(filename)
    qrcode = self.build_qrcode(code: file)
    qrcode.save
    File.delete(filename) if File.exist?(filename)
  end

  def generate_token
    SecureRandom.base64(32)
  end

  def create_subscription_on_razorpay
    options= {
      "plan_id": self.plan_id,
      "total_count": 1,
      "start_at": (Time.now + 30.days).to_i,
      "notes": {
        "notes_key": ""
      },
      "customer_notify": 1,
      "expire_by": (Time.now + 60.days).to_i,
    }
    plan = Razorpay::Subscription.create(options)
  end
end
    