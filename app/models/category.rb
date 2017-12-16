class Category < ApplicationRecord
  self.table_name = 'wp_terms'

  has_many :term_taxonomies, foreign_key: :term_id, primary_key: :term_id

  default_scope {
    includes(:term_taxonomies).
    where(wp_term_taxonomy: { taxonomy: 'category' })
  }

  has_many :posts_categories, foreign_key: :tag_id
  has_many :posts, through: :posts_categories
end
