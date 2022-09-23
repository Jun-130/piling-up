class CreateTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :targets do |t|
      t.date :deadline, null: false
      t.integer :amount, null: false
      t.integer :status, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
