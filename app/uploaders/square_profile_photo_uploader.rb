# encoding: utf-8

class SquareProfilePhotoUploader < ProfilePhotoUploader

  version :cropped do
    process :resize_to_fit => [400,400]
    process :crop_thumbnail
    process :resize_to_fill => [238,238]
    version :small do
      process :resize_to_fill => [77, 77]
    end
    version :tiny do
      process :resize_to_fill => [15, 15]
    end

  end

  def crop_thumbnail
    manipulate! do |img|
      img.crop(
        model.thumb_x.to_i,
        model.thumb_y.to_i,
        model.thumb_w.to_i,
        model.thumb_w.to_i
      )
    end
  end

end
