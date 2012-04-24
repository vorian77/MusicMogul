# encoding: utf-8

class SquareProfilePhotoUploader < ProfilePhotoUploader

  version :small do
    process :resize_to_fill => [77, 77]
  end

  version :tiny do
    process :resize_to_fill => [15, 15]
  end

end
