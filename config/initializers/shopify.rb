api_key = Rails.application.secrets[:shopify_api_key]
password = Rails.application.secrets[:shopify_api_password]
shop_name = Rails.application.secrets[:shopify_shop_name]

shop_url = "https://#{api_key}:#{password}@#{shop_name}.myshopify.com/admin"
ShopifyAPI::Base.site = shop_url
