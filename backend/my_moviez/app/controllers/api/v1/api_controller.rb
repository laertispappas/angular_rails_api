module Api
  module V1
    class ApiController < ApplicationController
      before_action :authenticate_request

      protected

      def current_user
        @current_user
      end

      def echo
        head :ok
      end

      private
      def authenticate_request
        @current_user = AuthorizeApiRequest.call(request.headers).result
        unauthorized! unless @current_user
      end

      def unauthorized!
        render json: { error: 'Not Authorized' }, status: 401
      end
    end
  end
end
