# encoding: utf-8

class ProfilePhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    File.join(Rails.root, 'tmp', 'uploaders')
  end

  version :large do
    process resize_to_fill: [400, 400]
  end

  version :medium do
    process resize_to_fill: [200, 200]
  end

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  version :masonry do
    process resize_to_fit: [200, 800]
  end

  def width
    image = MiniMagick::Image.open(@file.send(:file))
    image[:width]
  end

  def height
    image = MiniMagick::Image.open(@file.send(:file))
    image[:height]
  end

  def default_url
    "/assets/fallback/" + [version_name, "default.png"].compact.join('-')
  end
end
