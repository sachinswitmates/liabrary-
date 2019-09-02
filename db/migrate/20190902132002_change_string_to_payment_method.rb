class ChangeStringToPaymentMethod < ActiveRecord::Migration[5.2]
  def change
  	rename_column :bookings, :string, :payment_method
  end
end
