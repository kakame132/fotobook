class AddImagePhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :image, :text
  end
end
