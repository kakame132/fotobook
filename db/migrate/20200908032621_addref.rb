class Addref < ActiveRecord::Migration[6.0]
  def change
    add_reference :photos, :user, index: true, foreign_key: true
    add_reference :albums, :user, index: true, foreign_key: true
  end
end
