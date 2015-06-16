class AddAttachmentImageToPollenImages < ActiveRecord::Migration
  def self.up
    change_table :pollen_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :pollen_images, :image
  end
end
