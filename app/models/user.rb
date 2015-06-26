class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Devise is used for admin authentacation. 
  # You cannot manage the database without saying being logged in, 
  # This is handled in the controllers with before_action :authenticate_user! 
  # Check https://github.com/plataformatec/devise for more infomration.
  devise :database_authenticatable, :timeoutable
  
end
