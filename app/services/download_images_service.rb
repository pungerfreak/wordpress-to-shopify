class DownloadImagesService
  def self.call(content)
    downloader = self.new(content)

    downloader.download
  end

  def initialize(content)
    @content = content
  end

  def download
    urls = @content.scan(/(?<=src=")http:\/\/www\.fishingaddictsnorthwest\.com\/wp-content\/uploads\S*(?=")/)

    urls.each do |url|
      response = Net::HTTP.get(URI(url))
      path = File.join(Rails.root, 'public/downloads', url.split('/').last)

      open(path, "wb") do |file|
        file.write(response)
      end
    end
  end
end
