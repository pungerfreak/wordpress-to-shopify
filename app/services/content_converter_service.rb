class ContentConverterService
  def self.call(content)
    converter = self.new(content)
    
    converter.sanitize
    converter.handle_images
    converter.embed_videos
    converter.convert_captions
    converter.format_paragraphs
    converter.relink_images
    converter.update_internal_links
    converter.replace_domain_references

    converter.to_html
  end

  def initialize(content)
    @content = @converted_content = content
  end

  def convert_captions
    @converted_content.gsub!(/\[caption.*?\].*\[\/caption\]/) do |fragment|
      content = fragment.match(/\[caption.*?\](.*)\[\/caption\]/)[1]
      html = content.match(/(\<.*?\/.*\>)/)[1]
      text = content.match(/(.(?!>))+$/).to_s[1..-1].gsub(/\[(.*)$/, '').strip
      "<div class=\"image-with-caption\">#{html}<span>#{text}</span></div>"
    end
  end

  def embed_videos
    @converted_content.gsub!(/(?<!href=")((http.*youtu\.be\/|http.*youtube\.com\/watch\?v=)[a-zA-Z0-9_-]{11})/) do |url|
      token = url.last(11)
      "<iframe width=\"640\" height=\"360\" src=\"https://www.youtube.com/embed/#{token}\" frameborder=\"0\" allowfullscreen></iframe>"
    end
  end

  def format_paragraphs
    c = @converted_content.strip.gsub(/\A[\n]*|[\n]*\Z/, '') # strip newlines at beginning and end of content
    c = "#{c}</p>" unless c =~ /p>\Z|div>\Z/ # if content doesn't end with block tag, add </p>
    c = "<p>#{c}" unless c =~ /\A<p|\A<div/ # if content doesn't start with block tag, add <p>
    c.gsub!(/\n\t|(?<!\n)\n(?!\n)/, ' ') # strip single newlines and \n\t
    c.gsub!(/\n\n\s*\n\n(?=<\/div>)/, '') # \n\n \n\n</div> # remove two sets of newlines preceeding </div>
    c.gsub!(/\n\n(?=(<\/div>)|(<div>))|(?<=(<\/div>)|(<div>))\n\n/, '') # strip single \n\n preceeding or following <div> or </div>
    c.gsub!(/(?<=<\/p>)\n\n(?!<)/, '<p>') # </p>\n\n followed by a-zA-Z replace newlines with <p>
    c.gsub!(/(?<!>)\n\n(?=<p>)/, '</p>') # \n\n<p> replace \n\n with </p>
    c.gsub!(/[\n\n][\s*]*/, '</p><p>') # reduce one or more \n\n to </p><p>

    # Now to do some DOM manipulation to deal with <div> city
    doc = Nokogiri::HTML.parse c
    doc.search('/html/body/div').each do |div|
      # Just convert the top-level <div> to <p>
      div.name = 'p'
    end

    @converted_content = doc.search('/html/body/*').map(&:to_html).join
  end

  def handle_images
    @converted_content.gsub!(/(\<img.*?\>)/) do |tag|
      width = tag.match(/width="(\d*?)"/)[1].to_i
      klass = (width > 600) ? 'content-image--large' : ''
      klasses = " class=\"content-image #{klass}\""
      
      if tag =~ /class=".*?"/
        tag.gsub(/class=".*?"/, klasses)
      else
        tag[0..-2] + klasses + tag[-1]
      end
    end
  end

  def relink_images
    @converted_content.gsub!(/(?<=src=")(http|https):\/\/w*\.*fishingaddictsnorthwest\.com\/wp-content\/uploads\S*(?=")/) do |url|
      update_url(url)
    end

    @converted_content.gsub!(/\[embed\]|\[\/embed\]/, '')
  end

  def replace_domain_references
    @converted_content.gsub!(/http(s*):\/\/w*\.*fishingaddictsnorthwest\.com\/*|w*\.*fishingaddictsnorthwest\.com\/*/) do |url|
      'https://addicted.fishing'
    end
  end

  def sanitize
    @converted_content = Sanitize.fragment(@converted_content, sanitize_options)
  end

  def sanitize_options
    {
      elements: %w(h1 h2 h3 h4 h5 h6 p ul li ol a em strong b i img iframe div),
      attributes: {
        'a' => %w(href title),
        'img' => %w(src width height title alt class),
        'iframe' => %w(src width height allowfullscreen frameborder)
      }
    }
  end

  def to_html
    @converted_content
  end

  def update_internal_links
    doc = Nokogiri::HTML.parse @converted_content

    doc.search('//a').each do |element|
      href = element.attributes['href']

      if href.present? && href.value.match(/fishingaddictsnorthwest\.com/)
        url = href.value

        new_href = if url.match(/uploads/).present?
          # DownloadImagesService.single(url)
          update_url(url)
        elsif url.match(/com$|com\/$|tips-techniques\/bass-tips-techniques/).present?
          '/'
        elsif url.match(/p=88/).present?
          "/blogs/news/learning-to-love-the-spawnbass-fishing"
        elsif url.match(/columbia-river-guided-fishing/).present?
          "/pages/columbia-river-guided-fishing-trip"
        elsif url.match(/fishing-videos/).present?
          "/pages/fishing-videos"
        elsif url.match(/78141272/).present?
          "/collections/addicted-landing-nets/products/addicted-cradle-net"
        elsif url.match(/addicted-fishing-gear/).present?
          "/collections/all"
        else
          handle = Post.where(post_name: url.match(/com\/(.*)\/$/)[1]).first&.shopify_handle
          "/blogs/news/#{handle}" if handle
        end

        element.attributes['href'].value = new_href
      end
      # div.name = 'p'
      byebug
    end

    @converted_content = doc.search('/html/body/*').map(&:to_html).join
  end

  def update_url(url)
    filename = url.split('/').last
    shop_id = Rails.application.secrets[:shopify_shop_id]
    url_part = [shop_id.to_s[0..3], shop_id.to_s[4..-1]].join('/')

    "https://cdn.shopify.com/s/files/1/#{url_part}/files/#{filename}"
  end

  def validate
    document = "<!DOCTYPE html><head></head><body>#{@converted_content}</body></html>"
    h = PageValidations::HTMLValidation.new
    v = h.validation(document, SecureRandom.hex(4))
  end
end
