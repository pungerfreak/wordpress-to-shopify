class ContentConverterService
  def self.call(content)
    converter = self.new(content)
    
    converter.sanitize
    converter.handle_images
    converter.embed_videos
    converter.convert_captions
    converter.format_paragraphs
    converter.relink_images

    converter.to_html
  end

  def initialize(content)
    @content = @converted_content = content
  end

  def convert_captions
    @converted_content.gsub!(/\[caption.*?\].*\[\/caption\]$/) do |fragment|
      content = fragment.match(/\[caption.*?\](.*)\[\/caption\]$/)[1]
      html = content.match(/(\<.*?\/.*\>)/)[1]
      text = content.match(/(.(?!>))+$/).to_s[1..-1].gsub(/\[(.*)$/, '').strip
      "<div class=\"image-with-caption\">#{html}<span>#{text}</span></div>"
    end
  end

  def embed_videos
    @converted_content.gsub!(/http.*youtube\.com\/watch.*(?=\s|$)/) do |url|
      token = url.match(/\?v=(.*)/)[1].strip
      "<iframe width=\"640\" height=\"360\" src=\"https://www.youtube.com/embed/#{token}\" frameborder=\"0\" allowfullscreen></iframe>"
    end
  end

  def format_paragraphs
    c = @converted_content.strip.gsub(/\A[\n]*|[\n]*\Z/, '') # strip newlines at beginning and end of content
    c = "#{c}</p>" unless c =~ /p>|div>\Z/ # if content doesn't end with block tag, add </p>
    c = "<p>#{c}" unless c =~ /\A<p|<div/ # if content doesn't start with block tag, add <p>
    c.gsub!(/\n\t|(?<!\n)\n(?!\n)/, ' ') # strip single newlines and \n\t
    c.gsub!(/\n\n\s*\n\n(?=<\/div>)/, '') # \n\n \n\n</div> # remove two sets of newlines preceeding </div>
    c.gsub!(/\n\n(?=(<\/div>)|(<div>))|(?<=(<\/div>)|(<div>))\n\n/, '') # strip single \n\n preceeding or following <div> or </div>
    c.gsub!(/(?<=<\/p>)\n\n(?!<)/, '<p>') # </p>\n\n followed by a-zA-Z replace newlines with <p>
    c.gsub!(/(?<!>)\n\n(?=<p>)/, '</p>') # \n\n<p> replace \n\n with </p>
    c.gsub!(/[\n\n][\s*]*/, '</p><p>') # reduce one or more \n\n to </p><p>

    @converted_content = c
  end

  def handle_images
    @converted_content.gsub!(/(\<img.*?\>)/) do |tag|
      # has_class = tag =~ /class=".*size-[large|full].*?"/
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
    @converted_content.gsub!(/(?<=src=")http:\/\/www\.fishingaddictsnorthwest\.com\/wp-content\/uploads\S*(?=")/) do |url|
      filename = url.split('/').last
      # https://cdn.shopify.com/s/files/1/2372/4967/files/
      "https://cdn.shopify.com/s/files/1/2541/0190/files/#{filename}"
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

  def validate
    document = "<!DOCTYPE html><head></head><body>#{@converted_content}</body></html>"
    h = PageValidations::HTMLValidation.new
    v = h.validation(document, SecureRandom.hex(4))
  end
end
