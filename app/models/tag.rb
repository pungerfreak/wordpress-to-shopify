class Tag < ApplicationRecord
  self.table_name = 'wp_terms'

  has_many :term_taxonomies, foreign_key: :term_id, primary_key: :term_id

  default_scope {
    includes(:term_taxonomies).
    where(wp_term_taxonomy: { taxonomy: 'post_tag' })
  }

  has_many :posts_tag
  has_many :posts, through: :posts_tag
end
