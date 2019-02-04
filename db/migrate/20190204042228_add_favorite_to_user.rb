class AddFavoriteToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |t|
      t.references :meal, foreign_key: true, null: true
    end
  end
end
