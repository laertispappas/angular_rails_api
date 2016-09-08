module Api
  module V1
    class MoviesController < ApiController
      def echo
        render json: { result: "Authorized" }, status: 200
      end

      def index
      end

      def show
      end
    end
  end
end
