class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.references :movie, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :score, null: false, limit: 1

      t.timestamps
    end
  end
end
