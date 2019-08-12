class ChangeStreetToState < ActiveRecord::Migration[5.2]
  def change
  	rename_column :libraries, :street, :state
  end
end
