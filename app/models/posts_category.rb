class PostsCategory < ApplicationRecord
  self.table_name = 'posts_tags'

  belongs_to :post
  belongs_to :category, foreign_key: :tag_id
end
