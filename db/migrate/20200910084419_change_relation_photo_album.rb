class ChangeRelationPhotoAlbum < ActiveRecord::Migration[6.0]
  def change
    drop_table :albums_photos
    add_reference :photos, :albums, index: true, foreign_key: true
  end
end
