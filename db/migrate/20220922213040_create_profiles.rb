class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :age_id,           null: false
      t.integer :gender_id,        null: false
      t.integer :household_id,     null: false
      t.integer :annual_income_id, null: false
      t.integer :prefecture_id,    null: false
      t.integer :monthly_target,   null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
