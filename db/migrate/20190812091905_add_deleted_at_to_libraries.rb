class AddDeletedAtToLibraries < ActiveRecord::Migration[5.2]
  def change
    add_column :libraries, :deleted_at, :datetime
    add_index :libraries, :deleted_at
  end
end
