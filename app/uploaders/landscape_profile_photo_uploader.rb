# encoding: utf-8

class LandscapeProfilePhotoUploader < ProfilePhotoUploader

  version :small do
    process :resize_to_fit => [240,nil]
  end

end
