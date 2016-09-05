class ApplicationController < ActionController::API
  before_action :authenticate_request

  def current_user
    @current_user ||= unauthorized!
  end
  helper_method :current_user

  private
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    unauthorized! unless @current_user
  end

  def unauthorized!
    render json: { error: 'Not Authorized' }, status: 401
  end
end
