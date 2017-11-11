class Comment < ApplicationRecord
  self.table_name = 'wp_comments'

  belongs_to :post, foreign_key: :comment_post_ID
end
