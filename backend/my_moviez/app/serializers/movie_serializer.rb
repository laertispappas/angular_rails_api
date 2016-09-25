class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title, :total_score, :current_user_score

  def title
    object.title.titleize
  end

  def current_user_score
    scope.score_for(object)
  end

  def context_conditions
    Condition.all
  end
end
