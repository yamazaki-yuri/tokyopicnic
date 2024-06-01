class ParkImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  

  # Choose what kind of storage to use for this uploader:
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg png heic webp]
  end

  process :auto_orient
  process resize_to_limit: [800,800]
  process :convert_to_webp

  def auto_orient
    manipulate! do |img|
      img.auto_orient
      img
    end
  end

  def convert_to_webp
    manipulate! do |img|
      img.format 'webp'
      img
    end
  end

  def filename
    super.chomp(File.extname(super)) + '.webp' if original_filename.present?
  end
end
