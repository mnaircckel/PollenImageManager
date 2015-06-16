class AddTitleToPollenImages < ActiveRecord::Migration
  def change
    add_column :pollen_images, :title, :string
  end
end
