class SessionsController < ApplicationController
  def create
    command = AuthenticateUser.call(params[:email], params[:password])
    if command.success?
      render json: command.result
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def destroy
  end
end
