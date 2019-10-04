class Review < ApplicationRecord
    
  #associations
  belongs_to :user
  belongs_to :library
end
