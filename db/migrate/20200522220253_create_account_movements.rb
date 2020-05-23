class CreateAccountMovements < ActiveRecord::Migration[6.0]
  def change
    create_table :account_movements do |t|
      t.date :dt_movement, null: false
      t.integer :operation, null: false
      t.decimal :value, null: false

      t.timestamps
    end
  end
end
