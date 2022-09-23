class CreateBalances < ActiveRecord::Migration[6.0]
  def change
    create_table :balances do |t|
      t.integer :amount, null: false
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
  end
end
