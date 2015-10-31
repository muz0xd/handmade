module GalleriesHelper
  def image_width attach
    (Paperclip::Geometry.from_file attach.image.path(:thumbnail)).width
  end

  def image_height attach
    (Paperclip::Geometry.from_file attach.image.path(:thumbnail)).height
  end
end
