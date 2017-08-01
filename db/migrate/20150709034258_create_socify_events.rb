class CreateSocifyEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :socify_events do |t|
      t.string :name
      t.datetime :when
      t.references :user, index: true

      t.timestamps
    end
  end
end
