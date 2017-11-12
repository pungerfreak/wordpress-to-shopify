class Comment < ApplicationRecord
  include Mapper

  self.table_name = 'wp_comments'

  belongs_to :post, foreign_key: :comment_post_ID

  def mappings
    {
      article_id: [:shopify_post_id, -> (comment, attribute) { comment.post.send(attribute) }],
      author: :comment_author,
      # blog_id: ,
      # Need to figure out a way to get the HTML stripped down to textile or something
      body: [:comment_content, -> (comment, attribute) { ReverseMarkdown.convert comment.send(attribute) }],
      body_html: :comment_content,
      published_at: [:comment_date, -> (comment, attribute) { comment.send(attribute).iso8601 }],
      email: :comment_author_email,
      ip: :comment_author_IP,
      user_agent: :comment_agent
    }
  end
end
