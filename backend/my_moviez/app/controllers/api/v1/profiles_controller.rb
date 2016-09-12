module Api
  module V1
    class ProfilesController < ApiController
      # GET /api/v1/profile
      def show
        render json: current_user
      end
    end
  end
end
