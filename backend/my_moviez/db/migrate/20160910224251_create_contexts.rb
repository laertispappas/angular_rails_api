class CreateContexts < ActiveRecord::Migration[5.0]
  def change
    create_table :contexts do |t|
      t.string :type, null: false

      t.timestamps
    end
  end
end
