class AddUsernameToSocifyUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_users, :username, :string
    add_index :socify_users, :username, unique: true
  end
end
