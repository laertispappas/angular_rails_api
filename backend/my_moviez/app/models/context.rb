class Context < ApplicationRecord
  has_many :conditions, class_name: 'ContextCondition'
end
