class RemoveAvailabilityFromLibraries < ActiveRecord::Migration[5.2]
  def change
  	remove_column :libraries, :availability, :integer
  end
end
