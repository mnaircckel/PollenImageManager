class RemoveTagsFromPollenImages < ActiveRecord::Migration
  def change
    remove_column :pollen_images, :tags, :string
  end
end
