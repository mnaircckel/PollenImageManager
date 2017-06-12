class PollenImage < ActiveRecord::Base
  validates :title, :presence => true
  # Attached files are handled with CarrierWave
  # Attached files are sent to Cloudinary
  mount_uploader :picture, PictureUploader
end
