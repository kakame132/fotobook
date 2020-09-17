class ChangeLikeAlbumPhoto < ActiveRecord::Migration[6.0]
  def change
    change_column :photos, :likes, :integer, default:0
    change_column :albums, :likes, :integer, default:0
  end
end
