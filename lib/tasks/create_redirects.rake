task create_redirects: :environment do
  f = File.open(File.join(Rails.root, 'htaccess'), 'wb')

  Post.all.each do |post|
    old = "/#{post.post_name}/"
    not_old = "https://addicted.fishing/blogs/news/#{post.shopify_handle}"
    f.write "Redirect 301 #{old} #{not_old}\n"
  end

  Page.export.each do |page|
    old = "/#{page.post_name}/"
    not_old = "https://addicted.fishing/pages/#{page.shopify_handle}"
    f.write "Redirect 301 #{old} #{not_old}\n"
  end

  f.write "Redirect 301 /partnerships/ https://addicted.fishing/pages/partners\n"
  f.write "Redirect 301 /contact/ https://addicted.fishing/pages/contact-us\n"
  f.write "Redirect 301 / https://addicted.fishing/n"

  f.close
end
