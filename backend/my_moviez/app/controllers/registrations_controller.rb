class RegistrationsController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      command = AuthenticateUser.call(params[:email], params[:password])
      render json: { auth_token: command.result }, status: :created
    else
      render json: user.errors.messages, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    head :ok
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
