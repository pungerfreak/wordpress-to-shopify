class AddShopifyCommentIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :wp_comments, :shopify_comment_id, :string
  end
end
