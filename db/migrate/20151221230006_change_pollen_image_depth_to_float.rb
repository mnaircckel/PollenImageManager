class ChangePollenImageDepthToFloat < ActiveRecord::Migration
  def change
    change_column :pollen_images, :depth, :float
  end
end
