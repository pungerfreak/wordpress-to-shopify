class Post < ApplicationRecord
  self.table_name = 'wp_posts'

  default_scope { where(post_type: 'post') }

  has_many :comments, foreign_key: :comment_post_ID
end
