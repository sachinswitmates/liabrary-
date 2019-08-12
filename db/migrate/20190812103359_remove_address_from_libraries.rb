class RemoveAddressFromLibraries < ActiveRecord::Migration[5.2]
  def change
    remove_column :libraries, :address, :string
  end
end
