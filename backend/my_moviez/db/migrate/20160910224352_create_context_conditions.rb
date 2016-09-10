class CreateContextConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :context_conditions do |t|
      t.references :context, foreign_key: true, null: false
      t.string :condition
    end
  end
end
