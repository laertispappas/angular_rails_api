class MovieSerializer < ActiveModel::Serializer
  attributes :id, :title

  def title
    object.title.titleize
  end
end
