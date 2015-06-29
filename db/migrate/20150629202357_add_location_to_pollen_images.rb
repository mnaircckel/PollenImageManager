class AddLocationToPollenImages < ActiveRecord::Migration
  def change
    add_column :pollen_images, :location, :string
  end
end
