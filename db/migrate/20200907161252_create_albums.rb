class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.string "title"
      t.string "description"
      t.text "source"
      t.boolean "public", default: true
      t.timestamps
    end
  end
end
