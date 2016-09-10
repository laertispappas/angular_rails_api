class AddForreignKey < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :states, :countries
  end
end
