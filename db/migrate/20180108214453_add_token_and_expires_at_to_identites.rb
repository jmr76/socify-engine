class AddTokenAndExpiresAtToIdentites < ActiveRecord::Migration[5.1]
  def change
    add_column :identites, :token, :string
    add_column :identites, :expires_at, :datetime
  end
end
