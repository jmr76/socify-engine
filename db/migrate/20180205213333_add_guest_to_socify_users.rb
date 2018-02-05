class AddGuestToSocifyUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_users, :guest, :boolean, default: 0
  end
end
