class AddUserReferenceToMentors < ActiveRecord::Migration[7.0]
  def change
    add_reference :mentors, :user, null: false, foreign_key: true
  end
end
