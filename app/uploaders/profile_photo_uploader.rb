# encoding: utf-8

class ProfilePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    File.join(Rails.root, 'tmp', 'uploaders')
  end

  version :large do
    process resize_to_fit: [640, 480]
  end

  version :medium do
    process resize_to_fill: [200, 200]
  end

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  version :masonry do
    process resize_to_fit: [220, 800]
  end

  def width
    image = MiniMagick::Image.open(@file.respond_to?(:public_url) ? @file.public_url : @file.file)
    image[:width]
  end

  def height
    image = MiniMagick::Image.open(@file.respond_to?(:public_url) ? @file.public_url : @file.file)
    image[:height]
  end

  def default_url
    "/assets/fallback/" + [version_name, "default.png"].compact.join('-')
  end
end
