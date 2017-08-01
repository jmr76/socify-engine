class AddContentHtmlToSocifyPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_posts, :content_html, :text
  end
end
