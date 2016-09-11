class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  has_many :context_ratings, dependent: :destroy
  has_many :contexts, through: :context_ratings

  validates_presence_of :user
  validates_presence_of :movie
  validates_presence_of :context_ratings
  validates_presence_of :score
end
