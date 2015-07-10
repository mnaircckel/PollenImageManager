class AddMetadataToPollenImage < ActiveRecord::Migration
  def change
    add_column :pollen_images, :collection, :string
    add_column :pollen_images, :collection_number, :string
    add_column :pollen_images, :collector, :string
    add_column :pollen_images, :place_of_origin, :string
  end
end
