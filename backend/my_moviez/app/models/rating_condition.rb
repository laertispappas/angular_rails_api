class RatingCondition < ApplicationRecord
  belongs_to :rating
  belongs_to :condition
end
