# encoding: utf-8

class SquareProfilePhotoUploader < ProfilePhotoUploader

  version :fitted do
    process :resize_to_fit => [400,400]
  end
  version :cropped, :from_version => :fitted do
    process :crop_thumbnail
    process :resize_to_fill => [240,240]

    version :small do
      process :resize_to_fill => [77, 77]
    end
    version :tiny, :from_version => :small do
      process :resize_to_fill => [15, 15]
    end

  end

  def crop_thumbnail
    clear_profile_photo_square_crop if model.profile_photo_square_changed?

    manipulate! do |img|
      Rails.logger.debug("CROPS: {X: #{model.thumb_x}, Y: #{model.thumb_x}, W: #{model.thumb_x}}")
      if model.thumb_x && model.thumb_y && model.thumb_w
        img.crop(
          model.thumb_x.to_i,
          model.thumb_y.to_i,
          model.thumb_w.to_i,
          model.thumb_w.to_i
        )
      else
        img
      end
    end
  end

  def clear_profile_photo_square_crop
    Rails.logger.debug "CLEARING CROPS"
    model.thumb_x = nil
    model.thumb_y = nil
    model.thumb_w = nil
  end

end
