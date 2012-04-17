# encoding: utf-8

class ProfilePhotoUploader < CarrierWave::Uploader::Base

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def cache_dir
    File.join(Rails.root,'tmp','uploaders')
  end

end
