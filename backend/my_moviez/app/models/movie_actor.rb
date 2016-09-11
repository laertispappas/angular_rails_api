class MovieActor < ApplicationRecord
  belongs_to :movie
  belongs_to :actor

  validates_uniqueness_of :movie, scope: [:actor]
end
