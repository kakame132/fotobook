class ChangeRelation < ActiveRecord::Migration[6.0]
  def change
    remove_reference :photos, :albums, index: true, foreign_key: true
    add_reference :photos, :album, index: true, foreign_key: true
  end
end
