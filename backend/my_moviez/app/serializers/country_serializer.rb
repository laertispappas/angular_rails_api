class CountrySerializer < ActiveModel::Serializer
  attributes :code, :name
  has_many :states
end
