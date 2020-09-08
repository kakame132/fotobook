class AddLikeToPhotoAlbum < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :likes, :integer
    add_column :albums, :likes, :integer
  end
end
