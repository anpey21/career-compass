class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :goal_name
      t.integer :start_value
      t.integer :target_value
      t.integer :current_value
      t.string :unit
      t.string :goal_status
      t.string :theme
      t.date :goal_completion_date

      t.timestamps
    end
  end
end
