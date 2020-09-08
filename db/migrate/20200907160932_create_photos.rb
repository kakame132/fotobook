class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string "title"
      t.text "description"
      t.datetime "publishDate"
      t.boolean "public", default: true
      t.timestamps
    end
  end
end
