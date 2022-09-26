class CreateIntroductions < ActiveRecord::Migration[6.0]
  def change
    create_table :introductions do |t|
      t.string :title1,   null: false
      t.text   :content1, null: false
      t.string :title2
      t.text   :content2
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
