class MovieGenre < ApplicationRecord
  belongs_to :movie
  belongs_to :genre

  validates_uniqueness_of :movie, scope: [:genre]
end
