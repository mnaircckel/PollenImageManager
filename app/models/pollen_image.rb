class PollenImage < ActiveRecord::Base
  validates :title, :presence => true
  # Attached files are handled with paperclip, see https://github.com/thoughtbot/paperclip for more information
  # Attached files are sent to dropbox, this way storage can be accomplished on the cloud without using a premium database
  # See https://github.com/janko-m/paperclip-dropbox for more information about paperclip and dropbox
  has_attached_file :image,
    :default_url => "/images/missing_image.png",
    :storage => :dropbox,
    :dropbox_credentials => {app_key: "g0nkzx98joscnb1", app_secret: "bsabyg3e2kr9087", 
                             access_token: "wta4ult7indaz4n6", access_token_secret: "z8rgt2npm3mg7zy",
                             user_id: "49319691", access_type: "app_folder"},
    :styles => { :medium => "600x800" , :thumb => "120x120>"},    
    :dropbox_options => {:path => proc { |style| "#{style}/#{id}_#{image.original_filename}"}, :unique_filename => true}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
