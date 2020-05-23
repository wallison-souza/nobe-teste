class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :num_account, null: false
      t.string :num_branch, null: false
      t.decimal :balance, precision: 10, scale: 2, default: 0.0
      t.boolean :inative, default: false
      t.references :client
      t.timestamps
    end
  end
end
