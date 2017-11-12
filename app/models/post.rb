class Post < ApplicationRecord
  self.table_name = 'wp_posts'

  default_scope { where(post_type: 'post') }

  has_many :comments, foreign_key: :comment_post_ID
  has_one :image, foreign_key: :post_parent
  has_many :posts_tag
  has_many :tags, through: :posts_tag

  def mappings
    {
      title: :post_title,
      body_html: :post_content,
      summary_html: :post_excerpt,
      published_at: [:post_date, -> (post, attribute) { post.send(attribute).iso8601 }],
      tags: [:tags, -> (post, _attribute) { post.tags.map(&:name).join(', ') }],
      image: ([:image, -> (post, _attribute) { {src: post.image.url} }] unless self.image.blank?)
    }
  end

  def map(s_post)
    mappings.each do |item|
      attribute = item.first

      value = case item.last
      when Symbol then self.send(item.last)
      when Array then item.last.last.call(self, item.last.first)
      end

      s_post.send("#{attribute.to_s}=", value)
    end

    s_post
  end
end

