class RenameSocifyEventsWhenColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :socify_events, :when, :event_datetime
  end
end
