class CreateCities < ActiveRecord::Migration[5.0]
  def change
    create_table :cities do |t|
      t.references :state, foreign_key: true, null: false
      t.string :name, null: false
    end
  end
end
