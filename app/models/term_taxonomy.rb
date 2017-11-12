class TermTaxonomy < ApplicationRecord
  self.table_name = 'wp_term_taxonomy'

  belongs_to :tag, foreign_key: :term_id, primary_key: :term_id
end
