class AddAttributesToPollenImages < ActiveRecord::Migration
  def change
    add_column :pollen_images, :family, :string
    add_column :pollen_images, :latin_name, :string
    add_column :pollen_images, :common_name, :string
  end
end
