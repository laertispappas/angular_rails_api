class AddCityIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :city_id, :integer, index: true
    add_foreign_key :users, :cities
  end
end
