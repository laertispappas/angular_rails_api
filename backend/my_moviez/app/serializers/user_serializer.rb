class UserSerializer < ActiveModel::Serializer
  attributes :email, :auth_token

  def auth_token
    JsonWebToken.encode(user_id: object.id)
  end
end
