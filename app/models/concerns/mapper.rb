module Mapper
  extend ActiveSupport::Concern

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
