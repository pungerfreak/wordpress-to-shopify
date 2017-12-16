task export_posts: :environment do
  count = Post.count
  errors = []

  Post.all.each_with_index do |post, i|
    s_post = post.map(ShopifyAPI::Article.new)
    s_post.published = true
    
    if s_post.save
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
  count = Page.count
  errors = []

  Page.all.each_with_index do |page, i|
    s_page = page.map(ShopifyAPI::Page.new)
    s_page.shop_id = Rails.application.secrets[:shopify_shop_id]

    if s_page.save
      page.shopify_post_id = s_page.id
      page.shopify_handle = s_page.handle
      page.save
    else
      errors << "\nUnable to save page ##{page.id}: #{s_page.errors.full_messages.join(', ')}\n"
    end

    progress(i, count)
  end

  print "\n" + errors.join("\n")
end

task export_comments: :environment do
  count = Comment.count
  errors = {}

  Comment.all.each_with_index do |comment, i|
    s_comment = comment.map(ShopifyAPI::Comment.new)
    s_comment.status = 'published'
    s_comment.save

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
