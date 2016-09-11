class AddMoreAttrsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :director, :string
    add_column :movies, :country, :string
    add_column :movies, :language, :string
    add_column :movies, :year, :string
    add_column :movies, :budget, :string
  end
end
