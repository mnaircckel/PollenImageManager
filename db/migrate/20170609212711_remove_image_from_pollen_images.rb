class RemoveImageFromPollenImages < ActiveRecord::Migration
  def change
    remove_attachment :pollen_images, :image
  end
end
