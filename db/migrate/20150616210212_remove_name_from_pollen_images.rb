class RemoveNameFromPollenImages < ActiveRecord::Migration
  def change
    remove_column :pollen_images, :name, :string
  end
end
