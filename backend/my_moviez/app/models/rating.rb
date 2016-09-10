class Rating < ApplicationRecord
  belongs_to :context
  belongs_to :movie
  belongs_to :user
end
