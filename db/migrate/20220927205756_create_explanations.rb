class CreateExplanations < ActiveRecord::Migration[6.0]
  def change
    create_table :explanations do |t|
      t.text :content, null: false
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
  end
end
