class AddCommentHtmlToSocifyComments < ActiveRecord::Migration[5.1]
  def change
    add_column :socify_comments, :comment_html, :text
  end
end
