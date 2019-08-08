class BankAccount < ApplicationRecord  
  validates_presence_of :user_id
  validates :bank_name,presence: true
  validates :account_number,presence: true,uniqueness: true
  validates :ifsc_code,presence:true, length: { minimum: 10 }
  validates :account_holder_name,presence: true


  #association
  belongs_to :user


end
