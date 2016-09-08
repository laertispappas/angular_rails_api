class CreateUser
  prepend BaseCommand

  def initialize(user_params)
    @user_params = user_params
  end

  def call
    user = User.new(@user_params)
    if user.save
      JsonWebToken.encode(user_id: user.id)
    else
      errors.add :user_authentication, 'invalid credentials'
      false
    end
  end

end
