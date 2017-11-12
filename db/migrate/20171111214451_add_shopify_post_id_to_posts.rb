class AddShopifyPostIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :wp_posts, :shopify_post_id, :string
  end
end
