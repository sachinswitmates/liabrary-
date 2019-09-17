class Review < ApplicationRecord
  #validations
  validates :rating, presence: true
  validates :comment, presence: true

  #associations
  belongs_to :user
end
