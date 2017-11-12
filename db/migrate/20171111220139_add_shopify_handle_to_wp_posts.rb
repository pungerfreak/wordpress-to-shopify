class AddShopifyHandleToWpPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :wp_posts, :shopify_handle, :string
  end
end
