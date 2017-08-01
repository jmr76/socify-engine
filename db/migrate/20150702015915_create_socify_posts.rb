class CreateSocifyPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :socify_posts do |t|
      t.text :content, null: false
      t.references :user, index: true
      t.string :attachment

      t.timestamps
    end
  end
end
