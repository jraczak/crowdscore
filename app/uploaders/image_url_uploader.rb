# encoding: utf-8

class ImageUrlUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :fog

  include CarrierWave::MimeTypes
  process :set_content_type
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def default_url
    "/images/avatar.png"
  end

  process :resize_to_fill => [400, 400]
  
  version :thumb do
    process :resize_to_fill => [200, 200]
  end
end
