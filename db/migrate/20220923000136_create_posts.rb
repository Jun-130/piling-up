class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.date :month, null: false, unique: {scope: :user}
      t.integer :net_income,        null: false
      t.integer :housing,           null: false
      t.integer :utilities,         null: false
      t.integer :internet,          null: false
      t.integer :groceries,         null: false
      t.integer :daily_necessities, null: false
      t.integer :entertainment,     null: false
      t.integer :others,            null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
