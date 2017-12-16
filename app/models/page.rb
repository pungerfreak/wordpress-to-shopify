class Page < ApplicationRecord
  include Mapper

  self.table_name = 'wp_posts'

  default_scope { where(post_type: 'page') }

  def mappings
    {
      author: :post_author,
      body_html: [:post_content, -> (page, attribute) { ContentConverterService.call(page.send(attribute)) }],
      published_at: [:post_date, -> (page, attribute) { page.send(attribute).iso8601 }],
      title: :post_title
    }
  end
end
