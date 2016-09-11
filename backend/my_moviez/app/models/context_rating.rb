class ContextRating < ApplicationRecord
  belongs_to :rating
  belongs_to :context

  validates_uniqueness_of :rating, scope: [:context]
  validates_presence_of :rating, :context
end
