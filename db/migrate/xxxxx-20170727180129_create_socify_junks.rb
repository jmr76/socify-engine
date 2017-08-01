class CreateSocifyJunks < ActiveRecord::Migration[5.1]
  def change
    create_table :socify_junks do |t|
      t.name :string

      t.timestamps
    end
  end
end
