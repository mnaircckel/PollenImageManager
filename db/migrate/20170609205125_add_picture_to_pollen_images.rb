class AddPictureToPollenImages < ActiveRecord::Migration
  def change
    add_column :pollen_images, :picture, :string
  end
end
