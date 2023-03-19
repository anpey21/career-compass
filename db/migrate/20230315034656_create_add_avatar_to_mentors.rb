class CreateAddAvatarToMentors < ActiveRecord::Migration[7.0]
  def change
    create_table :add_avatar_to_mentors do |t|
      t.string :avatar
      t.string :photo
      t.timestamps
    end
  end
end
