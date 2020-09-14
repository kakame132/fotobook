class AddColumn < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.text "image"
    end
  end
end
