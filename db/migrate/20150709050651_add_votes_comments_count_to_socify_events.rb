class AddVotesCommentsCountToSocifyEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_events, :cached_votes_up, :integer, default: 0
    add_index  :socify_events, :cached_votes_up
    add_column :socify_events, :comments_count, :integer, default: 0
    add_index  :socify_events, :comments_count
  end
end
