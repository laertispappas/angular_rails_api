class Rating < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  has_many :rating_conditions, dependent: :destroy
  has_many :context_conditions, through: :rating_conditions

  validates_presence_of :user
  validates_presence_of :movie
  validates_presence_of :context_ratings
  validates_presence_of :score
end
