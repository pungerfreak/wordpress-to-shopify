class Page < ApplicationRecord
  include Mapper

  self.table_name = 'wp_posts'

  scope :export, -> { where(post_title: Page.pages_to_export) }
  default_scope { where(post_type: 'page') }

  def mappings
    {
      author: :post_author,
      body_html: [:post_content, -> (page, attribute) { ContentConverterService.call(page.send(attribute)) }],
      published_at: [:post_date, -> (page, attribute) { page.send(attribute).iso8601 }],
      title: :post_title
    }
  end

  def self.pages_to_export
    pages = <<-PAGES
Columbia River Guided Fishing Trip
Educate
Entertain
Salmon & Steelhead Fishing Tools
Fishing And Water Safety
Water Pollution
Respect the Resource
Stop Aquatic Hitchhikers
Learn Fish Species
Boating Education
Fishing Conservation
Fishing Videos
Fishing E-Cards
P-Line
Pro-Cure Bait Scents
Okuma Fishing USA
Hawken Fishing
Brad's Killer Fishing Gear
Simms
About
  PAGES

    pages.split("\n")
  end
end
