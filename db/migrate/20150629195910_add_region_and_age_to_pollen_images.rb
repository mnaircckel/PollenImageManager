class AddRegionAndAgeToPollenImages < ActiveRecord::Migration
  def change
    add_column :pollen_images, :age, :integer
    add_column :pollen_images, :region, :string
  end
end
