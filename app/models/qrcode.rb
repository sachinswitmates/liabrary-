class Qrcode < ApplicationRecord
  belongs_to :booking
  mount_uploader :code, QrcodeUploader
end
