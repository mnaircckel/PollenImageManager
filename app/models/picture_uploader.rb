class PictureUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  process :convert => 'jpeg'
  process :tags => ['post_picture']
  
  version :standard do
    resize_to_fit(600, 800)
  end
  
  version :thumb do
    resize_to_fit(120, 120)
  end
  
  def size_range
    1..10.megabytes
  end

end