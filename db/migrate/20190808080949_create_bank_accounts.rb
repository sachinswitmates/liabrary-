class CreateBankAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_accounts do |t|
      t.string :bank_name
      t.string :account_number
      t.string :ifsc_code
      t.string :account_holder_name
      t.integer :user_id
      t.timestamps
    end
      add_index :bank_accounts, :user_id
  end
end
