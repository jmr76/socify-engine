class AddMeritFieldsToSocifyUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_users, :sash_id, :integer
    add_column :socify_users, :level,   :integer, default: 0
  end
end
