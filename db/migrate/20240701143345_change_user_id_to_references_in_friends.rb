class ChangeUserIdToReferencesInFriends < ActiveRecord::Migration[7.1]
  def change
    # Remove the existing user_id column
    remove_column :friends, :user_id, :integer
    
    # Add the user_id column as a foreign key reference to the users table
    add_reference :friends, :user, null: false, foreign_key: true
  end
end