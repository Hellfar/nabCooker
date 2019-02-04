class AddDietToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :diet, :string
  end
end
