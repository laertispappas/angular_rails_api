class CreateState < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.integer :country_id, index: true, foreign_key: true, null: false
      t.string :code, limit: 4, null: false, index: true
      t.string :name, limit: 100, null: false, index: true
    end
  end
end
