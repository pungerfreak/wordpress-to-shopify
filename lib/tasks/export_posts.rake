task export_posts: :environment do
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

  Comment.all.each do |comment|
    s_comment = comment.map(ShopifyAPI::Comment.new)
    s_comment.status = 'published'
    s_comment.save

    puts "Unable to save comment ##{comment.id}: #{s_comment.errors.full_messages.join(', ')}" unless s_comment.valid?
  end

  Page.all.each do |page|
    s_page = page.map(ShopifyAPI::Page.new)
    s_page.shop_id = Rails.application.secrets[:shopify_shop_id]

    if s_page.save
      page.shopify_post_id = s_page.id
      page.shopify_handle = s_page.handle
      page.save
    else
      puts "Unable to save page ##{page.id}: #{s_page.errors.full_messages.join(', ')}"
    end
  end
end
