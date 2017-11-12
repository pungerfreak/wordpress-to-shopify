class Image < ApplicationRecord
  self.table_name = 'wp_posts'

  default_scope { where(post_type: 'attachment') }

  belongs_to :post, foreign_key: :post_parent

  def url
    guid
  end
end