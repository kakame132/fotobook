class AddColumnUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string "first_name", limit: 30
      t.string "last_name", limit: 30
      t.boolean "admin", default: false
    end
  end
end
