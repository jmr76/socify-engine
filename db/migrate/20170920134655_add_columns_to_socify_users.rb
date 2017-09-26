class AddColumnsToSocifyUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_users, :provider, :string
    add_column :socify_users, :uid, :string
  end
end
