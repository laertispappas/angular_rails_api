class CreateRatingConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :rating_conditions do |t|
      t.references :condition
      t.references :rating
    end
  end
end
