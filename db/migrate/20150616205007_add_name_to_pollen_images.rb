class AddNameToPollenImages < ActiveRecord::Migration
  def change
    add_column :pollen_images, :name, :string
  end
end
