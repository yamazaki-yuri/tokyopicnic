class ParkImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog
  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg png heic webp]
  end

  process :convert_to_webp

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
