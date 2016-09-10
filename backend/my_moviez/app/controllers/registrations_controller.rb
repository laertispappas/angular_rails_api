class RegistrationsController < ApplicationController
  def create
    command = CreateUser.call(user_params)
    if command.success?
      render json: command.result, status: :created
    else
      render json: command.errors, status: :unprocessable_entity
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
