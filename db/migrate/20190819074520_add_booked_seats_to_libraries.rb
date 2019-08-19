class AddBookedSeatsToLibraries < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :booked_seats, :integer
  end
end
