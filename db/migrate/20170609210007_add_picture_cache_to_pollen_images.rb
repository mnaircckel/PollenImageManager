class AddPictureCacheToPollenImages < ActiveRecord::Migration
  def change
    add_column :pollen_images, :picture_cache, :string
  end
end
