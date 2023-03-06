class CreatePriorities < ActiveRecord::Migration[7.0]
  def change
    create_table :priorities do |t|
      t.references :user, null: false, foreign_key: true
      t.string :priority_name
      t.integer :score

      t.timestamps
    end
  end
end
