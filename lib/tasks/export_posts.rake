task export_posts: :environment do
  count = Post.count
  errors = []

  Post.all.each_with_index do |post, i|
    api_post = if post.shopify_handle.present?
      ShopifyAPI::Article.where(handle: post.shopify_handle).first
    else
      ShopifyAPI::Article.new
    end
    s_post = post.map(api_post)
    s_post.published = true
    s_post.save

    if s_post.errors.full_messages.join(', ') =~ /image/i
      s_post.image = nil
      s_post.save
    end

    if s_post.valid?
      post.shopify_post_id = s_post.id
      post.shopify_handle = s_post.handle
      post.save
    else
      errors << "Unable to save post ##{post.id}: #{s_post.errors.full_messages.join(', ')}"
    end

    progress(i, count)
  end

  print "\n" + errors.join("\n")
end

task export_pages: :environment do
  # Changes have been made to the pages in Shopify. Uncomment this with caution.

  # count = Page.export.count
  # errors = []

  # Page.export.each_with_index do |page, i|
  #   api_page = if page.shopify_handle.present?
  #     ShopifyAPI::Page.where(handle: page.shopify_handle).first
  #   else
  #     ShopifyAPI::Page.new
  #   end
  #   s_page = page.map(api_page)
  #   s_page.shop_id = Rails.application.secrets[:shopify_shop_id]

  #   if s_page.save
  #     page.shopify_post_id = s_page.id
  #     page.shopify_handle = s_page.handle
  #     page.save
  #   else
  #     errors << "\nUnable to save page ##{page.id}: #{s_page.errors.full_messages.join(', ')}\n"
  #   end

  #   progress(i, count)
  # end

  # print "\n" + errors.join("\n")
end

task export_comments: :environment do
  count = Comment.count
  errors = []

  Comment.all.each_with_index do |comment, i|
    api_comment = if comment.shopify_comment_id.present?
      ShopifyAPI::Comment.where(id: comment.shopify_comment_id).first
    else
      ShopifyAPI::Comment.new
    end

    s_comment = comment.map(api_comment)
    s_comment.status = 'published'
    s_comment.save

    if s_comment.valid?
      comment.shopify_comment_id = s_comment.id
      comment.save
    end

    errors << "Unable to save comment ##{comment.id}: #{s_comment.errors.full_messages.join(', ')}" unless s_comment.valid?

    progress(i, count)
  end

  print "\n" + errors.join("\n")
end


def progress(index, total)
  @output = '' unless @output
  @output = @output + '.'
  completed = (((index + 1).to_f / total) * 100).round
  print "\r #{completed}% #{@output}"
  print " COMPLETE!\n" if completed == 100
end
