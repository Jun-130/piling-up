class CreateStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :statuses do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
