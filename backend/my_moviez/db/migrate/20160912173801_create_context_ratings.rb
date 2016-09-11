class CreateContextRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :context_ratings do |t|
      t.references :rating, foreign_key: true, null: false
      t.references :context, foreign_key: true, null: false

      t.timestamps
    end
  end
end
