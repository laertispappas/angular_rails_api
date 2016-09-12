module Api
  module V1
    class MoviesController < ApiController
      def echo
        render json: { result: "Authorized" }, status: 200
      end

      # GET api/v1/movies
      def index
        render json: Movie.all
      end

      # GET api/v1/movies/:id
      def show
        render Movie.find(params[:id])
      end
    end
  end
end
