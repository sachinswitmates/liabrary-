class RemoveNameFromBookings < ActiveRecord::Migration[5.2]
  def change
  	remove_column :bookings, :name, :string
  	remove_column :bookings, :email, :string
  	remove_column :bookings, :contact_number, :string
  end
end
