class DownloadImagesService
  def self.call(content)
    new(content).download_all
  end

  def self.single(url)
    new(nil).download(url)
  end

  def initialize(content)
    @content = content
  end

  def download(url)
    response = Net::HTTP.get(URI(url))
    path = File.join(Rails.root, 'public/downloads', url.split('/').last)

    open(path, "wb") do |file|
      file.write(response)
    end
  end

  def download_all
    urls = @content.scan(/(?<=src=")http:\/\/www\.fishingaddictsnorthwest\.com\/wp-content\/uploads\S*(?=")/)
    urls.each{|url| download(url) }
  end
end
