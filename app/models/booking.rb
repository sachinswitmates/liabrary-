class Booking < ApplicationRecord
	belongs_to :user
	belongs_to :library, optional: true
end
