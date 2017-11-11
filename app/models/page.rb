class Page < ApplicationRecord
  self.table_name = 'wp_posts'

  default_scope { where(post_type: 'page') }
end
