class AddPostsCountToSocifyUsers < ActiveRecord::Migration[5.1]
  def self.up
    add_column :socify_users, :posts_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :socify_users, :posts_count
  end
end
