class CreateSocifyIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :socify_identities do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
