class AuthenticateUser
  prepend BaseCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user
  end

  private
  attr_reader :email, :password

  def user
    user = User.find_by_email(email)
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
