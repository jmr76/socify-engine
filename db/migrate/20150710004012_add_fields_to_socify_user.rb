class AddFieldsToSocifyUser < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_users, :sex, :string, null: false, default: 'male'
    add_column :socify_users, :location, :string
    add_column :socify_users, :dob, :date
    add_column :socify_users, :phone_number, :string
  end
end
