class AddDegreeToFriends < ActiveRecord::Migration[7.1]
  def change
    add_column :friends, :degree, :integer
    # Ensure degree can only be 1, 2, or 3
    add_check_constraint :friends, 'degree IN (1, 2, 3)', name: 'degree_value_constraint'
  end
end
