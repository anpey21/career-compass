class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :priority, null: false, foreign_key: true
      t.string :question

      t.timestamps
    end
  end
end
