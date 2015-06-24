class CreateIndexEntries < ActiveRecord::Migration
  def change
    create_table :index_entries do |t|
      t.string :latin_name
      t.string :family
      t.string :common_name

      t.timestamps null: false
    end
  end
end
