class CreateSocifyFriendlyIdSlugs < ActiveRecord::Migration[5.1]
  def change
    create_table :socify_friendly_id_slugs do |t|
      t.string   :slug,           null: false
      t.integer  :sluggable_id,   null: false
      t.string   :sluggable_type, limit: 50
      t.string   :scope
      t.datetime :created_at
    end
    add_index :socify_friendly_id_slugs, :sluggable_id
    add_index :socify_friendly_id_slugs, %i[slug sluggable_type]
    add_index :socify_friendly_id_slugs, %i[slug sluggable_type scope], unique: true, name: "idx_socify_slug_type_scope"
    add_index :socify_friendly_id_slugs, :sluggable_type
  end
end
