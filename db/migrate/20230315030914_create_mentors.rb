class CreateMentors < ActiveRecord::Migration[7.0]
  def change
    create_table :mentors do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :field
      t.integer :price_per_hour
      t.string :country
      t.integer :experience
      t.timestamps
    end
  end
end
