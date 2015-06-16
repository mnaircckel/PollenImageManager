class CreatePollenImages < ActiveRecord::Migration
  def change
    create_table :pollen_images do |t|
      t.string :tags

      t.timestamps null: false
    end
  end
end
