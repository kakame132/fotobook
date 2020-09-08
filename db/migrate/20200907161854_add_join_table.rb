class AddJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :photos, :albums do |t|
      t.index :photo_id
      t.index :album_id
    end
  end
end
