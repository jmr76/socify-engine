class AddCounterCacheToSocifyPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_posts, :comments_count, :integer, default: 0
    add_index  :socify_posts, :comments_count
  end
end
