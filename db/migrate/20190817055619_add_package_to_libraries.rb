class AddPackageToLibraries < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :monthly, :integer
    add_column :libraries, :quaterly, :integer
    add_column :libraries, :halfyearly, :integer
    add_column :libraries, :yearly, :integer
  end
end
