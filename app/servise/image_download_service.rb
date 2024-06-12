require 'open-uri'
require 'mini_magick'

class ImageDownloadService
  def initialize(url)
    @url = url
  end

  def download_and_process
    downloaded_image = URI.open(@url)
    image = MiniMagick::Image.read(downloaded_image)
    image.format "webp"

    temp_file = Tempfile.new(['park_image', '.webp'])
    image.write(temp_file.path)
    temp_file
  rescue => e
    Rails.logger.error "Error downloading or processing image: #{e.message}"
    nil
  end
end
