class CreateMovieGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_genres do |t|
      t.references :movie, foreign_key: true
      t.references :genre, foreign_key: true
    end
  end
end