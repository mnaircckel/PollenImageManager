class AddDepthAndSlideInfoToPollenImage < ActiveRecord::Migration
  def change
    add_column :pollen_images, :focal_plane, :string
    add_column :pollen_images, :grain_number, :string
    add_column :pollen_images, :depth, :integer
  end
end
