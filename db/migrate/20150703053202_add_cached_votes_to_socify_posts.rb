class AddCachedVotesToSocifyPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_posts, :cached_votes_up, :integer, default: 0
    add_index  :socify_posts, :cached_votes_up
  end
end
