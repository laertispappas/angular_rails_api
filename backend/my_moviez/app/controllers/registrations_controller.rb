class RegistrationsController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
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
