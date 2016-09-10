class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :code, limit: 4, null: false, index: true, uniq: true
      t.string :name, limit: 50, null: false, index: true, uniq: true
    end
  end
end
