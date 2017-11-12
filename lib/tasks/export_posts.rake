task :export_posts => :environment do
  Post.all.each do |post|
    s_post = post.map(ShopifyAPI::Article.new)
    s_post.published = true
    
    if s_post.save
      post.shopify_post_id = s_post.id
      post.shopify_handle = s_post.handle
      post.save
    else
      puts "Unable to save post ##{post.id}: #{s_post.errors.full_messages.join(', ')}"
    end
  end
end
