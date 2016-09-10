module Api
  module V1
    class ProfilesController < ApiController
      def show
        render json: current_user
      end
    end
  end
end
