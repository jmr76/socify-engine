class CreateSocifyIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :socify_identities do |t|
      t.references :socify_user, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
