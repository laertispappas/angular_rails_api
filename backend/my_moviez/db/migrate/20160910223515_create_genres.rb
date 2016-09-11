class CreateGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :genres do |t|
      t.references :movie, foreign_key: true, null: false
      t.string :name, index: true, null: false, unique: true
    end
  end
end