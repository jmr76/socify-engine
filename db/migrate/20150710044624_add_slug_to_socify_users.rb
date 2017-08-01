class AddSlugToSocifyUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_users, :slug, :string
    add_index :socify_users, :slug, unique: true
  end
end
