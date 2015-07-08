class AddNotesToPollenImage < ActiveRecord::Migration
  def change
    add_column :pollen_images, :notes, :string
  end
end
