class ChangeSeatTypeInLibraries < ActiveRecord::Migration[5.2]
  def change
  	change_column :libraries, :seats, :integer
  	change_column :libraries, :availability, :integer
  end
end
