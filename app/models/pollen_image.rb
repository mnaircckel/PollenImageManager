class PollenImage < ActiveRecord::Base
  has_attached_file :image,
    :storage => :dropbox,
    :dropbox_credentials => {app_key: "g0nkzx98joscnb1", app_secret: "bsabyg3e2kr9087", 
                             access_token: "wta4ult7indaz4n6", access_token_secret: "z8rgt2npm3mg7zy",
                             user_id: "49319691", access_type: "app_folder"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
