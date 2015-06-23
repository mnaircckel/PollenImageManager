class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Funciton to overide normal devise functionality
  def after_sign_in_path_for(resource)
    pollen_images_path(resource) # <- After sign in, redirect to main index
  end
end
