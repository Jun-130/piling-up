class CreateFixedProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :fixed_profiles do |t|
      t.string :age,             null: false
      t.string :gender,          null: false
      t.string :household,       null: false
      t.string :annual_income,   null: false
      t.string :prefecture,      null: false
      t.integer :monthly_target, null: false
      t.integer :target
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
  end
end
