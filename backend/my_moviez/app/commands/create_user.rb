class CreateUser
  prepend BaseCommand

  def initialize(user_params)
    @user_params = user_params
  end

  def call
    user = User.new(@user_params)
    user.save ? user : add_errors && false
  end

  private
  def add_errors
    errors.add :user_authentication, 'invalid credentials'
  end
end
