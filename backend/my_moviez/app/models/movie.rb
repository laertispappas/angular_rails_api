class Movie < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :movie_actors, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :actors, through: :movie_actors
  has_many :genres, through: :movie_genres
end
