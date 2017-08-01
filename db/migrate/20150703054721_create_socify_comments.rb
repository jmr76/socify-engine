class CreateSocifyComments < ActiveRecord::Migration[5.1]
  def self.up
    create_table :socify_comments do |t|
      t.string :title, limit: 50, default: ""
      t.text :comment
      t.references :commentable, polymorphic: true
      t.references :user
      t.string :role, default: "comments"
      t.timestamps
    end

    add_index :socify_comments, :commentable_type
    add_index :socify_comments, :commentable_id
    add_index :socify_comments, :user_id, name: "idx_socify_comments_on_user_id"
  end

  def self.down
    drop_table :socify_comments
  end
end
