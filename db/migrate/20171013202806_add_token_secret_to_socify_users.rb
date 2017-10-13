class AddTokenSecretToSocifyUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_users, :token, :string
    add_column :socify_users, :secret, :string
  end
end
