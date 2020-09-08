class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true
      t.belongs_to :user
      t.timestamps
    end
  end
end
